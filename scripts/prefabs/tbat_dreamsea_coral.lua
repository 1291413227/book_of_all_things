require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/tbat_dreamsea_coral.zip"),
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
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    -- inst:SetDeploySmartRadius(0.75)
    -- MakeObstaclePhysics(inst, .2)

    inst.AnimState:SetBank("tbat_dreamsea_coral")
    inst.AnimState:SetBuild("tbat_dreamsea_coral")
    inst.AnimState:PlayAnimation("idle", true)

    inst.Light:SetColour(1, 1, 1) -- 白色光
    inst.Light:SetRadius(1)       -- 设置光照范围
    inst.Light:SetFalloff(0.7)    -- 设置光照衰减率
    inst.Light:SetIntensity(0.7)  -- 设置光照强度
    inst.Light:Enable(true)

    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh") -- 加个泛光,游戏中可以在官方设置中开启关闭

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

return Prefab("tbat_dreamsea_coral", fn, assets, prefabs),
    MakePlacer("tbat_dreamsea_coral_placer", "tbat_dreamsea_coral", "tbat_dreamsea_coral", "idle")
