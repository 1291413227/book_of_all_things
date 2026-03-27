-- 测试用
local tbat_rose_twin_goose_give_item = nil
if GLOBAL.BOOKOFEVERYTHING_SETS.ENABLEDMODS["old_tbat"] then
    tbat_rose_twin_goose_give_item = "tbat_food_valorbush"
else
    tbat_rose_twin_goose_give_item = "petals"
end

-- =======================================
--[[ 动作定义 ]]
-- =======================================
local actions = {
    TBAT_READ = {
        id = "TBAT_READ",
        mount_valid = true,
        strfn = function(act)
            return "GENERIC"
        end,
        fn = function(act)
            local targ = act.target or act.invobject
            if targ ~= nil and act.doer ~= nil then
                if targ.components.tbat_note ~= nil then
                    targ.components.tbat_note:Read(act.doer)
                    return true
                end
            end
            return false
        end,
    },
    TBAT_SALVAGE = {
        id = "TBAT_SALVAGE",
        priority = 6,
        strfn = function(act)
            return "GENERIC"
        end,
        fn = function(act)
            local targ = act.target
            if targ ~= nil and act.doer ~= nil then
                if targ.components.tbat_pool ~= nil then
                    return targ.components.tbat_pool:Salvage(act.doer)
                end
            end
            return false
        end,
    },
    TBAT_GOOSE_GIVE = {
        id = "TBAT_GOOSE_GIVE",
        priority = 6,
        strfn = function(act)
            return "GENERIC"
        end,
        fn = function(act)
            local item = act.invobject
            local targ = act.target
            if targ == nil or item == nil then
                return false
            end
            local now_exp = targ:GetTwinGooseExp()
            local need_exp = 99 - now_exp
            local stack_size = item.components.stackable ~= nil and item.components.stackable:StackSize() or 1
            local add_exp = math.min(need_exp, stack_size)
            targ:AddTwinGooseExp(add_exp)
            if item.components.stackable ~= nil then
                item.components.stackable:Get(add_exp):Remove()
            else
                item:Remove()
            end
            return true
        end,
    },
    TBAT_BIRD_GIVE = {
        id = "TBAT_BIRD_GIVE",
        priority = 6,
        strfn = function(act)
            return "GENERIC"
        end,
        fn = function(act)
            local note = act.invobject
            local targ = act.target
            local dor = act.doer
            local inventory = dor.components.inventory
            local notes_checklist = require("tbat_notes_checklist")
            local number = note._number:value()
            local dialogue = notes_checklist["tbat_item_notes_of_adventurer_" .. number] and notes_checklist["tbat_item_notes_of_adventurer_" .. number].dialogue or "……"
            local items = notes_checklist["tbat_item_notes_of_adventurer_" .. number] and notes_checklist["tbat_item_notes_of_adventurer_" .. number].items or nil
            if targ == nil or note == nil or dor == nil or items == nil or inventory == nil then
                return false
            end
            if targ.components.talker then
                targ.components.talker:Say(dialogue)
            end
            for k, v in pairs(items) do
                if type(v) == "table" then
                    if math.random() < v[2] then
                        local item = SpawnPrefab(k)
                        inventory:GiveItem(item, nil, targ:GetPosition())
                    end
                elseif v == 1 then
                    local item = SpawnPrefab(k)
                    inventory:GiveItem(item, nil, targ:GetPosition())
                elseif v > 1 then
                    local item = SpawnPrefab(k)
                    if item.components.stackable then
                        item.components.stackable:SetStackSize(v)
                        inventory:GiveItem(item, nil, targ:GetPosition())
                    else
                        inventory:GiveItem(item, nil, targ:GetPosition())
                        for i = 2, v do
                            local item1 = SpawnPrefab(k)
                            inventory:GiveItem(item1, nil, targ:GetPosition())
                        end
                    end
                end
            end
            note.components.stackable:Get(1):Remove() -- 消耗笔记
            notes_checklist = nil                     -- 释放资源
            return true
        end,
    },
}

for _, action in pairs(actions) do
    local _action = Action()
    for k, v in pairs(action) do
        _action[k] = v
    end
    AddAction(_action)
end

actions = nil -- 释放资源

-- =======================================
--[[ 动作行为:就是执行动作的人物动画 ]]
-- =======================================
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.TBAT_READ, "reading_tbat_adventurers_notes"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.TBAT_READ, "reading_tbat_adventurers_notes"))
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.TBAT_SALVAGE, "dolongaction"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.TBAT_SALVAGE, "dolongaction"))
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.TBAT_GOOSE_GIVE, "give"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.TBAT_GOOSE_GIVE, "give"))
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.TBAT_BIRD_GIVE, "give"))
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.TBAT_BIRD_GIVE, "give"))

-- =======================================
-- [[ ADD COMPONENT ACTION ]]
-- SCENE		using an object in the world                                        -- args: inst, doer, actions, right
-- USEITEM		using an inventory item on an object in the world                   -- args: inst, doer, target, actions, right
-- POINT		using an inventory item on a point in the world                     -- args: inst, doer, pos, actions, right, target
-- EQUIPPED		using an equiped item on yourself or a target object in the world   -- args: inst, doer, target, actions, right
-- INVENTORY	using an inventory item                                             -- args: inst, doer, actions, right
-- =======================================

-- target是对象,inst是手中或鼠标上物品,doer是做动作的玩家,right是是否为右键
AddComponentAction("INVENTORY", "inventoryitem", function(inst, doer, _actions, right)
    if inst:HasTag("tbat_note") then
        table.insert(_actions, ACTIONS.TBAT_READ)
    end
end)
AddComponentAction("SCENE", "tbat_pool", function(inst, doer, _actions, right)
    if inst:HasTag("tbat_pool") and right then
        table.insert(_actions, ACTIONS.TBAT_SALVAGE)
    end
end)
AddComponentAction("INVENTORY", "container_proxy", function(inst, doer, _actions, right)
    if inst:HasTag("tbat_rose_goose_egg") and inst.components.container_proxy:CanBeOpened() and doer.replica.inventory ~= nil then
        table.insert(_actions, ACTIONS.RUMMAGE)
    end
end)
AddComponentAction("USEITEM", "inventoryitem", function(inst, doer, target, _actions, right)
    if inst.prefab == tbat_rose_twin_goose_give_item and target:HasTag("tbat_rose_twin_goose") and not target:HasTag("tbat_rose_twin_goose_2") then
        table.insert(_actions, ACTIONS.TBAT_GOOSE_GIVE)
    end
    if inst:HasTag("tbat_note") and target.prefab == "tbat_npc_emerald_feather_bird" then
        table.insert(_actions, ACTIONS.TBAT_BIRD_GIVE)
    end
end)

-- 动作兼容行为排队论
local queueractlist = {
    TBAT_BIRD_GIVE = "allclick",
}
local actionqueuer_status, actionqueuer_data = pcall(require, "components/actionqueuer")
if actionqueuer_status then
    if AddActionQueuerAction and next(queueractlist) then
        for k, v in pairs(queueractlist) do
            AddActionQueuerAction(v, k, true)
        end
    end
end

-- 先创建动作再命名
STRINGS.ACTIONS.TBAT_READ = {
    GENERIC = STRINGS.TBAT_ACTIONS.TBAT_READ.GENERIC,
}

STRINGS.ACTIONS.TBAT_SALVAGE = {
    GENERIC = STRINGS.TBAT_ACTIONS.TBAT_SALVAGE.GENERIC,
}
STRINGS.CHARACTERS.GENERIC.ACTIONFAIL.TBAT_SALVAGE = {
    NO_FISH = STRINGS.TBAT_ACTIONS.TBAT_SALVAGE.ACTIONFAIL.NO_FISH,
    NO_BAIT = STRINGS.TBAT_ACTIONS.TBAT_SALVAGE.ACTIONFAIL.NO_BAIT,
    ALREADY_SALVAGED_TODAY = STRINGS.TBAT_ACTIONS.TBAT_SALVAGE.ACTIONFAIL.ALREADY_SALVAGED_TODAY,
}

STRINGS.ACTIONS.TBAT_GOOSE_GIVE = {
    GENERIC = STRINGS.TBAT_ACTIONS.TBAT_GOOSE_GIVE.GENERIC,
}

STRINGS.ACTIONS.TBAT_BIRD_GIVE = {
    GENERIC = STRINGS.TBAT_ACTIONS.TBAT_BIRD_GIVE.GENERIC,
}
