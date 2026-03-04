local ScreenWidget = require "widgets/screen"
local Widget = require "widgets/widget"
local ImageButton = require "widgets/imagebutton"
local Text = require "widgets/text"
local Image = require "widgets/image"

local AdventurersNotesScreen = Class(ScreenWidget, function(self, owner, number)
    ScreenWidget._ctor(self, "AdventurersNotesScreen")

    self.owner = owner
    self.note_number = number or 1

    local black = self:AddChild(ImageButton("images/global.xml", "square.tex"))
    black.image:SetVRegPoint(ANCHOR_MIDDLE)
    black.image:SetHRegPoint(ANCHOR_MIDDLE)
    black.image:SetVAnchor(ANCHOR_MIDDLE)
    black.image:SetHAnchor(ANCHOR_MIDDLE)
    black.image:SetScaleMode(SCALEMODE_FILLSCREEN)
    black.image:SetTint(0, 0, 0, .5)
    black:SetOnClick(function() TheFrontEnd:PopScreen() end)
    black:SetHelpTextMessage("")

    self.proot = self:AddChild(Widget("ROOT"))
    self.proot:SetScaleMode(SCALEMODE_PROPORTIONAL) -- 保证界面在不同分辨率下看起来一致
    self.proot:SetHAnchor(ANCHOR_MIDDLE)            -- 界面水平居中
    self.proot:SetVAnchor(ANCHOR_MIDDLE)            -- 界面垂直居中
    self.proot:SetPosition(0, 50, 0)                -- 遵照旧mod的参数

    -- 设置背景
    self.bg = self.proot:AddChild(Image("images/tbat_ui.xml", "note_background.tex"))
    self.bg:SetScale(0.45, 0.45, 0.45) -- 遵照旧mod的参数

    self.button_close = self.proot:AddChild(ImageButton("images/tbat_ui.xml", "note_button_close.tex",
        "note_button_close.tex", "note_button_close.tex", "note_button_close.tex"))
    self.button_close:SetScale(0.45, 0.45, 0.45) -- 遵照旧mod的参数
    self.button_close:SetOnClick(function() TheFrontEnd:PopScreen() end)
    self.button_close:SetPosition(270, 234, 0)

    -- 设置界面文本
    self.title_text = self.proot:AddChild(Text(HEADERFONT, 28))
    self.title_text:SetString("冒险家笔记" .. "·" .. self.note_number) -- 标题显示冒险家笔记和编号
    self.title_text:SetColour(0, 0, 0, 1)
    self.title_text:SetPosition(-110, 140, 0)

    local note_info = require("languages.tbat_note_text_chinese")

    self.note_text = self.proot:AddChild(self:BuildNoteText(note_info[self.note_number] and note_info[self.note_number].text or "暂无内容", note_info[self.note_number] and note_info[self.note_number].text_size or 24))
    self.note_text:SetPosition(0, -75, 0)

    note_info = nil -- 释放资源

    self.default_focus = self.bg
    SetAutopaused(true) -- 若单人玩家开了自动暂停,开启界面时会自动暂停游戏
end)

function AdventurersNotesScreen:OnDestroy()
    SetAutopaused(false)

    POPUPS.ADVENTURERSNOTESSCREEN:Close(self.owner)

    AdventurersNotesScreen._base.OnDestroy(self)
end

-- 笔记文本构建函数
function AdventurersNotesScreen:BuildNoteText(hint, text_size)
    local w = Widget("note_text_root")
    local note_text = w:AddChild(Text(HEADERFONT, text_size or 24))
    note_text:SetHAlign(ANCHOR_LEFT)
    note_text:SetVAlign(ANCHOR_TOP)
    note_text:SetRegionSize(350, 360)
    note_text:EnableWordWrap(true)
    note_text:SetColour(0, 0, 0, 1)
    note_text:SetString(hint or "No Data")
    note_text:SetPosition(0, 0)
    return w
end

return AdventurersNotesScreen
