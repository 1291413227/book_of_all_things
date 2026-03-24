require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/tbat_pet_washer.zip"),
}

local prefabs =
{
    "collapse_big",
}

local WORK_DURATION = 9
local FINISH_CHAT_MESSAGE = "衣服洗好啦，快来收走吧。"
-- Foreground icon uses "images/npcchatflairs.xml" with "<icon>.tex".
local FINISH_CHAT_ICON = "npcchatflair_none"
-- Background icon uses "images/profileflair.xml" with "<iconbg>.tex".
local FINISH_CHAT_ICON_BG = "default"

local function isworking(inst)
    return inst.components.container ~= nil and not inst.components.container.canbeopened
end

local function onopen(inst)
    inst.AnimState:PlayAnimation("open", true)
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_open")
end

local function onclose(inst)
    inst.AnimState:PlayAnimation("closed", true)
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_close")
end

local function stopworking(inst)
    if not isworking(inst) then
        return
    end

    inst._tbat_worktask = nil

    if inst.components.container ~= nil then
        inst.components.container.canbeopened = true
    end

    -- if TheWorld ~= nil and TheWorld.ismastersim and inst._tbat_working_userid ~= nil then
    --     SendModRPCToClient(
    --         GetClientModRPC("BOOKOFALLTHINGS", "ChatMessage"),
    --         inst._tbat_working_userid,
    --         STRINGS.NAMES.TBAT_PET_WASHER or "萌宠洗衣机",
    --         FINISH_CHAT_MESSAGE,
    --         FINISH_CHAT_ICON,
    --         FINISH_CHAT_ICON_BG,
    --         true
    --     )
    -- end
    -- inst._tbat_working_userid = nil
    if TheWorld ~= nil and TheWorld.ismastersim then
        TheNet:Announce("[萌宠洗衣机温馨提示] 衣服洗好啦，快来收走吧。")
    end

    inst.AnimState:PlayAnimation("use_pst")
    inst.AnimState:PushAnimation("closed", true)
end

local function startworking(inst, doer)
    if inst.components.container == nil or not inst.components.container.canbeopened then
        return false
    end

    inst.components.container.canbeopened = false
    inst._tbat_working_userid = doer ~= nil and doer.userid or nil

    if inst._tbat_worktask ~= nil then
        inst._tbat_worktask:Cancel()
        inst._tbat_worktask = nil
    end

    inst.AnimState:PlayAnimation("use_pre")
    inst.AnimState:PushAnimation("use_loop", true)
    inst._tbat_worktask = inst:DoTaskInTime(WORK_DURATION, stopworking)
    return true
end

local function onhammered(inst, worker)
    if inst._tbat_worktask ~= nil then
        inst._tbat_worktask:Cancel()
        inst._tbat_worktask = nil
    end
    inst._tbat_working_userid = nil
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_big")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.AnimState:SetBuild("tbat_pet_washer")
    inst.AnimState:SetBank("tbat_pet_washer")
    inst.AnimState:PlayAnimation("closed", true)

    inst:AddTag("structure")
    inst:AddTag("tbat_pet_washer") -- 萌宠洗衣机标签

    inst:AddComponent("talker")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("tbat_pet_washer")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true
    inst.components.container:EnableInfiniteStackSize(true) -- 启用无限堆叠

    inst._tbat_worktask = nil
    inst._tbat_working_userid = nil
    inst.StartTBATWork = startworking
    inst.StopTBATWork = stopworking

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(9)
    inst.components.workable:SetOnFinishCallback(onhammered)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    return inst
end

return
    Prefab("tbat_pet_washer", fn, assets, prefabs),
    MakePlacer("tbat_pet_washer_placer", "tbat_pet_washer", "tbat_pet_washer", "closed")
