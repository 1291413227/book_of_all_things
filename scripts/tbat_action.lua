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

-- 先创建动作再命名
STRINGS.ACTIONS.TBAT_READ = {
    GENERIC = STRINGS.TBAT_ACTIONS.TBAT_READ.GENERIC,
}
