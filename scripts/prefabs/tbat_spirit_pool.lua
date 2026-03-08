require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/tbat_spirit_pool.zip"),
}

local prefabs =
{
    "collapse_big",
}

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_big")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end

local function GetFishFn(inst)
    local container = inst.components.container
    if container == nil then
        return "weregoose_splash_med2"
    end

    if inst.fishingrod == nil and inst.fisherman == nil then
        return "weregoose_splash_med2"
    end

    if inst.fishingrod ~= "tbat_eq_fantasy_tool" then
        if inst.fisherman.components.talker then
            inst.fisherman:DoTaskInTime(20 * FRAMES, function(fisherman)
                fisherman.components.talker:Say("我大概需要一个美貌与实用并存的工具")
            end)
        end
        return "weregoose_splash_med2"
    end

    local bait = container:GetItemInSlot(5)
    if bait == nil then
        if inst.fisherman.components.talker then
            inst.fisherman:DoTaskInTime(20 * FRAMES, function(fisherman)
                fisherman.components.talker:Say("没有诱饵，我不是姜太公")
            end)
        end
        return "weregoose_splash_med2"
    end

    local fishslots = { 1, 2, 3, 4, 6, 7, 8, 9 }
    local slot = fishslots[math.random(#fishslots)]
    local fishitem = container:GetItemInSlot(slot)

    if fishitem == nil then
        if inst.fisherman.components.talker then
            inst.fisherman:DoTaskInTime(20 * FRAMES, function(fisherman)
                fisherman.components.talker:Say("没有饲养鱼或饲养鱼太少")
            end)
        end
        return "weregoose_splash_med2"
    end

    if bait.components.stackable ~= nil then
        local consumed = bait.components.stackable:Get(1)
        if consumed ~= nil then
            consumed:Remove()
        end
    else
        bait:Remove()
    end

    return fishitem.prefab
end

local function commonfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    -- MakePondPhysics(inst, 1.95)

    inst.AnimState:SetBuild("tbat_spirit_pool")
    inst.AnimState:SetBank("tbat_spirit_pool")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)

    inst.MiniMapEntity:SetIcon("tbat_spirit_pool.tex")

    inst:AddTag("watersource")              -- 水源
    inst:AddTag("pond")
    inst:AddTag("antlion_sinkhole_blocker") -- 不受蚁狮地震影响
    inst:AddTag("birdblocker")              -- 鸟不会停留在池塘上

    inst.no_wet_prefix = true               -- 没有潮湿的前缀

    -- inst:SetDeploySmartRadius(2)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("tbat_spirit_pool")

    inst:AddComponent("preserver")
    inst.components.preserver:SetPerishRateMultiplier(TUNING.FISH_BOX_PRESERVER_RATE)

    inst:AddComponent("fishable")
    inst.components.fishable:SetGetFishFn(GetFishFn)

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(9)
    inst.components.workable:SetOnFinishCallback(onhammered)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:AddComponent("watersource")

    return inst
end

local function pondcrab()
    local inst = commonfn()

    if not TheWorld.ismastersim then
        return inst
    end

    return inst
end

return
    Prefab("tbat_spirit_pool", pondcrab, assets, prefabs),
    MakePlacer("tbat_spirit_pool_placer", "tbat_spirit_pool", "tbat_spirit_pool", "idle")
