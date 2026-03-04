local assets =
{
    Asset("ANIM", "anim/tbat_adventurers_notes.zip"),
    Asset("INV_IMAGE", "tbat_item_notes_of_adventurer") -- 支持T控制台显示物品图标
}

-- local function DisplayNameFn(inst)
--     return STRINGS.NAMES.TBAT_ADVENTURERS_NOTES .. "·" .. (inst._number:value() or "")
-- end

local function OnReadBook(inst, doer)
    local number = inst._number:value()
    doer:ShowPopUp(POPUPS.ADVENTURERSNOTESSCREEN, true, number or 1)
end

local function makenote(index)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank("tbat_adventurers_notes")
        inst.AnimState:SetBuild("tbat_adventurers_notes")
        inst.AnimState:PlayAnimation("idle")

        inst._number = net_smallbyte(inst.GUID, "tbat_adventurers_notes._number", "note_number_change")

        -- inst.displaynamefn = DisplayNameFn

        inst:AddComponent("floater")
        inst.components.floater:SetSize("med")
        inst.components.floater:SetVerticalOffset(0.05)
        inst.components.floater:SetScale({ 0.85, 0.45, 0.85 }) -- 遵照旧mod的参数
        inst.components.floater.SwitchToFloatAnim = function(self, ...)
            self.inst.AnimState:PlayAnimation("idle_water")
        end
        inst.components.floater.SwitchToDefaultAnim = function(self, ...)
            self.inst.AnimState:PlayAnimation("idle")
        end

        inst:AddTag("tbat_note")

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        -----------------------------------

        inst._number:set(index) -- 笔记的编号

        inst:AddComponent("inspectable")

        inst:AddComponent("inventoryitem")
        -- 支持小木牌绘制
        inst.components.inventoryitem:ChangeImageName("tbat_item_notes_of_adventurer")

        inst:AddComponent("tbat_note")
        inst.components.tbat_note.onreadfn = OnReadBook

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

        -- 可以当燃料但不能被引燃
        inst:AddComponent("fuel")
        inst.components.fuel.fuelvalue = TUNING.MED_FUEL

        MakeHauntableLaunch(inst)

        return inst
    end

    -- 保持旧mod的预制体命名
    return Prefab("tbat_item_notes_of_adventurer" .. "_" .. index, fn, assets)
end

local prefs = {}
local note_num = 39
for index = 1, note_num, 1 do
    table.insert(prefs, makenote(index))
end

return unpack(prefs)
