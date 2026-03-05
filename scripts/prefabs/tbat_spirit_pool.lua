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

local function commonfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakePondPhysics(inst, 1.95)

    inst.AnimState:SetBuild("tbat_spirit_pool")
    inst.AnimState:SetBank("tbat_spirit_pool")
    inst.AnimState:PlayAnimation("idle", true)

    inst.MiniMapEntity:SetIcon("tbat_spirit_pool.tex")

    inst:AddTag("watersource")              -- 水源
    inst:AddTag("pond")
    inst:AddTag("antlion_sinkhole_blocker") -- 不受蚁狮地震影响
    inst:AddTag("birdblocker")              -- 鸟不会停留在池塘上

    inst.no_wet_prefix = true               -- 没有潮湿的前缀

    inst:SetDeploySmartRadius(2)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    -- inst:AddComponent("fishable")

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
