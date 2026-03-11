require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/tbat_dreamweaver_peachcloud_tree.zip"),
}

local prefabs =
{
    "collapse_small",
}

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("straw")
    inst:Remove()
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    -- inst:SetDeploySmartRadius(0.4)
    -- MakeObstaclePhysics(inst, .3)

    inst.MiniMapEntity:SetIcon("tbat_dreamweaver_peachcloud_tree.tex")

    inst.AnimState:SetBank("tbat_dreamweaver_peachcloud_tree")
    inst.AnimState:SetBuild("tbat_dreamweaver_peachcloud_tree")
    inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("structure")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("lootdropper")

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = TUNING.SANITY_SMALL / 60

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(9)
    inst.components.workable:SetOnFinishCallback(onhammered)

    MakeHauntableWork(inst)

    return inst
end

return Prefab("tbat_dreamweaver_peachcloud_tree", fn, assets, prefabs),
    MakePlacer("tbat_dreamweaver_peachcloud_tree_placer", "tbat_dreamweaver_peachcloud_tree", "tbat_dreamweaver_peachcloud_tree", "idle")
