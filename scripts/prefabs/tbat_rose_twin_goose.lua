require("prefabutil")

local assets =
{
    Asset("ANIM", "anim/tbat_rose_twin_goose.zip"),
}

local prefabs =
{
    "collapse_small",
}

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("stone")
    inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    -- inst:SetDeploySmartRadius(DEPLOYSPACING_RADIUS[DEPLOYSPACING.DEFAULT] / 2)
    -- MakeObstaclePhysics(inst, .4)

    inst.MiniMapEntity:SetPriority(5)
    inst.MiniMapEntity:SetIcon("tbat_rose_twin_goose.tex") -- 小地图图标

    inst.AnimState:SetBank("tbat_rose_twin_goose")
    inst.AnimState:SetBuild("tbat_rose_twin_goose")
    inst.AnimState:PlayAnimation("idle1")

    inst:AddTag("structure")
    inst:AddTag("tbat_rose_twin_goose")
    inst:AddTag("prototyper")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("prototyper")
    inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES.TURFCRAFTING

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(9)
    inst.components.workable:SetOnFinishCallback(onhammered)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    return inst
end

return Prefab("tbat_rose_twin_goose", fn, assets, prefabs),
    MakePlacer("tbat_rose_twin_goose_placer", "tbat_rose_twin_goose", "tbat_rose_twin_goose", "idle1")
