-- ================================================================
--[[给幻灵水池容器做特殊处理,实现特殊槽位多slots]]
-- ================================================================
local TARGET_CONTAINER_PREFAB = "tbat_spirit_pool" -- 仅干预自己mod的容器,避免和其他mod冲突

local function IsTargetContainer(self, item)
    return self.inst ~= nil
        and self.inst.prefab == TARGET_CONTAINER_PREFAB
end

local function GetStackable(item)
    if item == nil then
        return nil
    end

    return (item.components ~= nil and item.components.stackable)
        or (item.replica ~= nil and item.replica.stackable)
        or nil
end

local function FindFirstAvailableSpecificSlot(self, item)
    local empty_slot = nil

    for i = 1, self:GetNumSlots() do
        if self:itemtestfn(item, i) then
            local slot_item = self:GetItemInSlot(i)
            if slot_item == nil then
                empty_slot = empty_slot or i
            elseif self:AcceptsStacks()
                and slot_item.prefab == item.prefab
                and slot_item.skinname == item.skinname then
                local stackable = GetStackable(slot_item)
                if stackable ~= nil and not stackable:IsFull() then
                    return i
                end
            end
        end
    end

    return empty_slot
end

local Container = require("components/container")
if not Container._tbat_specific_slot_hooked then
    Container._tbat_specific_slot_hooked = true

    local _GetSpecificSlotForItem = Container.GetSpecificSlotForItem
    function Container:GetSpecificSlotForItem(item, ...)
        if not IsTargetContainer(self, item) then
            return _GetSpecificSlotForItem(self, item, ...)
        end

        return FindFirstAvailableSpecificSlot(self, item)
    end
end

local ContainerReplica = require("components/container_replica")
if not ContainerReplica._tbat_specific_slot_hooked then
    ContainerReplica._tbat_specific_slot_hooked = true

    local _GetSpecificSlotForItem = ContainerReplica.GetSpecificSlotForItem
    function ContainerReplica:GetSpecificSlotForItem(item, ...)
        if not IsTargetContainer(self, item) then
            return _GetSpecificSlotForItem(self, item, ...)
        end

        return FindFirstAvailableSpecificSlot(self, item)
    end
end

-- ================================================================
--[[给幻灵水池的鱼池组件做特殊处理]]
-- ================================================================
local Fishable = require("components/fishable")
local _HookFish = Fishable.HookFish
-- 剩余鱼数量始终在最大值
function Fishable:HookFish(fisherman, ...)
    if self.inst ~= nil and self.inst.prefab == TARGET_CONTAINER_PREFAB then
        -- 让幻灵水池的鱼池组件在被钓鱼杆钓到时也能正常工作
        local fish = _HookFish(self, fisherman, ...)
        if fish.build == nil then
            fish.build = "000"
        end
        self.fishleft = self.maxfish or 10
        return fish
    end

    return _HookFish(self, fisherman, ...)
end

-- ================================================================
--[[钓竿组件特殊处理，好复杂。。。]]
-- ================================================================
local FishingRod = require("components/fishingrod")
local _OnUpdate = FishingRod.OnUpdate
local _StopFishing = FishingRod.StopFishing
local _Hook = FishingRod.Hook
function FishingRod:OnUpdate(dt, ...)
    if self:IsFishing() and self.target and self.target.prefab == TARGET_CONTAINER_PREFAB then
        self.target.components.container.canbeopened = false
    end
    _OnUpdate(self, dt, ...)
end

function FishingRod:StopFishing(...)
    if self.target and self.target.prefab == TARGET_CONTAINER_PREFAB then
        self.target.components.container.canbeopened = true
    end
    _StopFishing(self, ...)
end

-- 这样多人钓鱼的时候应该不会彼此覆盖吧,有待实装验证
function FishingRod:Hook(...)
    self.target.tbat_fisherman = self.fisherman
    self.target.tbat_fishingrod = self.inst.prefab
    _Hook(self, ...)
    self.target.tbat_fisherman = nil
    self.target.tbat_fishingrod = nil
end

-- ================================================================
--[[冒险家笔记相关]]
-- ================================================================
-- 旧mod的逻辑可以直接用
local note_loot_old = {
    ["beequeen"] = { "tbat_item_notes_of_adventurer_2", "tbat_item_notes_of_adventurer_3" },
    ["dragonfly"] = { "tbat_item_notes_of_adventurer_4", "tbat_item_notes_of_adventurer_5" },
    ["bearger"] = { "tbat_item_notes_of_adventurer_6", "tbat_item_notes_of_adventurer_7", "tbat_item_notes_of_adventurer_8" },
    ["mutatedbearger"] = { "tbat_item_notes_of_adventurer_6", "tbat_item_notes_of_adventurer_7", "tbat_item_notes_of_adventurer_8" },
    ["klaus"] = { "tbat_item_notes_of_adventurer_9", "tbat_item_notes_of_adventurer_10" },
    ["deerclops"] = { "tbat_item_notes_of_adventurer_11", "tbat_item_notes_of_adventurer_12", "tbat_item_notes_of_adventurer_13", "tbat_item_notes_of_adventurer_14" },
    ["mutateddeerclops"] = { "tbat_item_notes_of_adventurer_11", "tbat_item_notes_of_adventurer_12", "tbat_item_notes_of_adventurer_13", "tbat_item_notes_of_adventurer_14" },
    ["antlion"] = { "tbat_item_notes_of_adventurer_15", "tbat_item_notes_of_adventurer_16" },
    ["eyeofterror"] = { "tbat_item_notes_of_adventurer_17", "tbat_item_notes_of_adventurer_18" },
    ["twinofterror1"] = { "tbat_item_notes_of_adventurer_17", "tbat_item_notes_of_adventurer_18" },
    ["twinofterror2"] = { "tbat_item_notes_of_adventurer_17", "tbat_item_notes_of_adventurer_18" },
    ["moose"] = { "tbat_item_notes_of_adventurer_19", "tbat_item_notes_of_adventurer_20" },
    ["daywalker2"] = { "tbat_item_notes_of_adventurer_21", "tbat_item_notes_of_adventurer_22", "tbat_item_notes_of_adventurer_23" },
}

local note_loot_new = {
    ["daywalker"] = { "tbat_item_notes_of_adventurer_24", "tbat_item_notes_of_adventurer_25" },
    ["toadstool"] = { "tbat_item_notes_of_adventurer_26", "tbat_item_notes_of_adventurer_27", "tbat_item_notes_of_adventurer_28" },
    ["toadstool_dark"] = { "tbat_item_notes_of_adventurer_26", "tbat_item_notes_of_adventurer_27", "tbat_item_notes_of_adventurer_28" },
    ["minotaur"] = { "tbat_item_notes_of_adventurer_29", "tbat_item_notes_of_adventurer_30", "tbat_item_notes_of_adventurer_31" },
    ["stalker_atrium"] = { "tbat_item_notes_of_adventurer_32", "tbat_item_notes_of_adventurer_33", "tbat_item_notes_of_adventurer_34" },
    ["sharkboi"] = { "tbat_item_notes_of_adventurer_35", "tbat_item_notes_of_adventurer_36" },
    ["malbatross"] = { "tbat_item_notes_of_adventurer_37", "tbat_item_notes_of_adventurer_38", "tbat_item_notes_of_adventurer_39" },
}

if not GLOBAL.BOOKOFEVERYTHING_SETS.ENABLEDMODS["old_tbat"] then
    for k, v in pairs(note_loot_old) do
        note_loot_new[k] = v
    end
end

note_loot_old = nil -- 释放旧表的内存占用

local function droploot(inst, data)
    local target = data and data.inst
    local prefab = target and target.prefab
    local ret = note_loot_new[prefab]
    if ret and target and target.components.lootdropper then
        local ret_prefab = ret[math.random(#ret)]
        target.components.lootdropper:SpawnLootPrefab(ret_prefab)
    end
end

AddPrefabPostInit("world", function(inst)
    if not TheWorld.ismastersim then
        return
    end

    TheWorld:ListenForEvent("entity_droploot", droploot)
end)

-- ================================================================
--[[容器UI相关改动及扩充]]
-- ================================================================
local ContainerWidget = require("widgets/containerwidget")
local ImageButton = require "widgets/imagebutton"
local Image = require "widgets/image"
local _Open = ContainerWidget.Open
local _Close = ContainerWidget.Close
function ContainerWidget:Open(container, doer, ...)
    _Open(self, container, doer, ...)
    local widget = container.replica.container:GetWidget()
    local isreadonlycontainer = container.replica.container:IsReadOnlyContainer()

    -- 更改容器按钮的贴图
    if widget.buttoninfo ~= nil then
        self.button:SetTextures(
            widget.buttoninfo.atlas or "images/ui.xml",
            widget.buttoninfo.normal or "button_small.tex",
            widget.buttoninfo.focus or "button_small_over.tex",
            widget.buttoninfo.disabled or "button_small_disabled.tex",
            widget.buttoninfo.down or nil,
            widget.buttoninfo.selected or nil,
            widget.buttoninfo.scale or { 1, 1 },
            widget.buttoninfo.offset or { 0, 0 }
        )
    end

    -- 添加额外按钮,按钮在很多函数都有涉及,我只在Close函数里补充了和官方一致的逻辑,其他函数就不补充了,如果有需要再说吧
    if widget.tbat_buttons ~= nil then
        for i, buttoninfo in ipairs(widget.tbat_buttons) do
            self["tbat_button" .. i] = self:AddChild(ImageButton(
                buttoninfo.atlas or "images/ui.xml",
                buttoninfo.normal or "button_small.tex",
                buttoninfo.focus or "button_small_over.tex",
                buttoninfo.disabled or "button_small_disabled.tex",
                buttoninfo.down or nil,
                buttoninfo.selected or nil,
                buttoninfo.scale or { 1, 1 },
                buttoninfo.offset or { 0, 0 }
            ))
            self["tbat_button" .. i].image:SetScale(1.07)
            self["tbat_button" .. i].text:SetPosition(2, -2)
            self["tbat_button" .. i]:SetPosition(buttoninfo.position)
            self["tbat_button" .. i]:SetText(buttoninfo.text)
            -- 按钮上的贴图
            if buttoninfo.floating_image then
                self["tbat_button" .. i].floating_image = self["tbat_button" .. i]:AddChild(Image(
                    buttoninfo.floating_image.atlas,
                    buttoninfo.floating_image.image
                ))
                self["tbat_button" .. i].floating_image:SetScale(buttoninfo.floating_image.scale or 1)
            end
            -- 按钮功能
            if buttoninfo.fn ~= nil then
                self["tbat_button" .. i]:SetOnClick(function()
                    if doer ~= nil then
                        if doer:HasTag("busy") then
                            return
                        elseif doer.components.playercontroller ~= nil then
                            local iscontrolsenabled, ishudblocking = doer.components.playercontroller:IsEnabled()
                            if not (iscontrolsenabled or ishudblocking) then
                                return
                            end
                        end
                    end
                    buttoninfo.fn(container, doer)
                end)
            end
            self["tbat_button" .. i]:SetFont(BUTTONFONT)
            self["tbat_button" .. i]:SetDisabledFont(BUTTONFONT)
            self["tbat_button" .. i]:SetTextSize(33)
            self["tbat_button" .. i].text:SetVAlign(ANCHOR_MIDDLE)
            self["tbat_button" .. i].text:SetColour(0, 0, 0, 1)

            -- 按钮是否启用
            if buttoninfo.validfn ~= nil then
                local function refresh_button_state()
                    if buttoninfo.validfn(container, doer, self["tbat_button" .. i]) then
                        self["tbat_button" .. i]:Enable()
                    else
                        self["tbat_button" .. i]:Disable()
                    end
                end
                refresh_button_state()
                self["tbat_button" .. i].inst:ListenForEvent("tbat_level_change", refresh_button_state, TheWorld)
            end

            if TheInput:ControllerAttached() or isreadonlycontainer then
                self["tbat_button" .. i]:Hide()
            end

            self["tbat_button" .. i].inst:ListenForEvent("continuefrompause", function()
                local isreadonlycontainer = container and container:IsValid() and container.replica.container and container.replica.container:IsReadOnlyContainer() or false
                if TheInput:ControllerAttached() or isreadonlycontainer then
                    self["tbat_button" .. i]:Hide()
                else
                    self["tbat_button" .. i]:Show()
                end
            end, TheWorld)
        end
    end

    self:Refresh()
end

function ContainerWidget:Close(...)
    -- 移除额外按钮,目前最高设定10个好了
    if self.isopen then
        for i = 1, 10 do
            if self["tbat_button" .. i] ~= nil then
                self["tbat_button" .. i]:Kill()
                self["tbat_button" .. i] = nil
            else
                break
            end
        end
    end

    _Close(self, ...)
end

-- ================================================================
--[[钩一下自己的世界容器]]
-- ================================================================
local tbat_rose_twin_goose_table = {
    "tbat_rose_twin_goose_container",
    "tbat_rose_twin_goose_wall_container",
    "tbat_rose_twin_goose_fence_container",
    "tbat_rose_twin_goose_plantable_container",
    "tbat_rose_twin_goose_miscellaneous_container",
    "tbat_rose_twin_goose_material_container",
    "tbat_rose_twin_goose_decorate_container",
}
local function add_to_openlist(inst, player, other_container)
    if player ~= nil and other_container ~= nil then
        inst.tbat_openlist[player] = other_container
    end
end
local function remove_from_openlist(inst, player)
    if player ~= nil then
        inst.tbat_openlist[player] = nil
    end
end
for _, prefab in ipairs(tbat_rose_twin_goose_table) do
    AddPrefabPostInit(prefab, function(inst)
        if not TheWorld.ismastersim then
            return
        end
        inst.tbat_openlist = {}
        inst:ListenForEvent("onopenother", function(_inst, data)
            if data ~= nil and data.doer ~= nil and data.other ~= nil then
                add_to_openlist(_inst, data.doer, data.other)
            end
        end)
        inst:ListenForEvent("oncloseother", function(_inst, data)
            if data ~= nil and data.doer ~= nil then
                remove_from_openlist(_inst, data.doer)
            end
        end)
    end)
end

-- ================================================================
--[[世界hook,双生鹅容器相关]]
-- ================================================================
local function FindTwinGooseEntity(exclude_inst)
    for _, ent in pairs(Ents) do
        if ent ~= exclude_inst and ent.prefab == "tbat_rose_twin_goose" and ent:IsValid() then
            return ent
        end
    end
end

local function GetTwinGooseLevel(goose)
    if goose == nil or not goose:IsValid() then
        return 0
    end

    local level = goose.GetTwinGooseLevel ~= nil and goose:GetTwinGooseLevel() or goose.tbat_level or 1
    if level < 1 then
        return 1
    elseif level > 2 then
        return 2
    end

    return level
end

local function GetWorldTwinGooseLevelComponent(world)
    if world == nil or world.net == nil or world.net.components == nil then
        return nil
    end
    return world.net.components.tbat_twin_goose_level
end

local function GetWorldTwinGooseLevel(world)
    local component = GetWorldTwinGooseLevelComponent(world)
    return component ~= nil and component:GetLevel() or 0
end

local function SetWorldTwinGooseLevel(world, level, force_dirty)
    local component = GetWorldTwinGooseLevelComponent(world)
    if component ~= nil and component.SetLevel ~= nil then
        component:SetLevel(level, force_dirty)
        return component:GetLevel()
    end
    return 0
end

local function RefreshTwinGooseState(world)
    if world == nil then
        return nil
    end

    local goose = world._tbat_rose_twin_goose
    if goose == nil or not goose:IsValid() then
        goose = FindTwinGooseEntity()
    end

    world._tbat_rose_twin_goose = goose
    local synced_level = SetWorldTwinGooseLevel(world, GetTwinGooseLevel(goose))
    world:PushEvent("tbat_refresh_twin_goose_state", { level = synced_level })

    return goose
end

local function AddTwinGooseLevelNetComponent(inst)
    if inst.components.tbat_twin_goose_level == nil then
        inst:AddComponent("tbat_twin_goose_level")
    end
end

AddPrefabPostInit("forest_network", AddTwinGooseLevelNetComponent)
AddPrefabPostInit("cave_network", AddTwinGooseLevelNetComponent)

AddPrefabPostInit("world", function(inst)
    inst.GetTBATTwinGooseLevel = GetWorldTwinGooseLevel
    inst.SetTBATTwinGooseLevel = SetWorldTwinGooseLevel
    inst._tbat_refresh_twin_goose_state = RefreshTwinGooseState

    if not inst.ismastersim then
        return
    end

    inst:ListenForEvent("ms_playeractivated", function()
        inst:DoTaskInTime(0, inst._tbat_refresh_twin_goose_state)
    end)

    inst:DoTaskInTime(0, inst._tbat_refresh_twin_goose_state)
end)

