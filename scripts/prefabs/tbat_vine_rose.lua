require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/tbat_vine_rose.zip"),
}

local prefabs =
{
    "collapse_small",
}

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    -- inst:SetDeploySmartRadius(0.75)
    -- MakeObstaclePhysics(inst, .2)

    inst.AnimState:SetBank("tbat_vine_rose")
    inst.AnimState:SetBuild("tbat_vine_rose")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("structure")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(9)
    inst.components.workable:SetOnFinishCallback(onhammered)

    MakeHauntableWork(inst)

    return inst
end

return Prefab("tbat_vine_rose", fn, assets, prefabs),
    MakePlacer("tbat_vine_rose_placer", "tbat_vine_rose", "tbat_vine_rose", "idle")
