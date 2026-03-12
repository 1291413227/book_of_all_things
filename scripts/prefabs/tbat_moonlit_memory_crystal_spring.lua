require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/tbat_moonlit_memory_crystal_spring.zip"),
}

local assets_waterfall =
{
    Asset("ANIM", "anim/tbat_moonlit_memory_crystal_spring_waterfall.zip"),
}

local prefabs =
{
    "collapse_big",
    "tbat_moonlit_memory_crystal_spring_waterfall",
}

local prefabs_waterfall =
{
    "tbat_moonlit_memory_crystal_spring",
}

local function OnIsFullmoon(inst, isfullmoon)
    if not isfullmoon then
        return
    end
    local duration = 1.6

    local elapsed = 0

    -- 每 0.3 秒执行一次
    local task
    task = inst:DoPeriodicTask(0.3, function()
        -- 超时 -> 停止
        if elapsed >= duration then
            task:Cancel() -- ← 终止执行
            return
        end
        elapsed = elapsed + 0.3

        ------------------------------------------------
        -- 掉落
        ------------------------------------------------
        local x, y, z = inst.Transform:GetWorldPosition()
        local dx = math.random(-2, 2)
        local dz = math.random(-2, 2)
        local pos = Vector3(x + dx, y + 20, z + dz)

        local item_prefab = TUNING.BOOKOFALLTHINGS.OLD_TBAT and "tbat_material_memory_crystal" or "moonrocknugget"
        local item = SpawnPrefab(item_prefab)
        if item ~= nil then
            if item.Physics ~= nil then
                item.Physics:Teleport(pos:Get())
            else
                item.Transform:SetPosition(pos:Get())
            end

            if item.components.inventoryitem then
                item.components.inventoryitem:DoDropPhysics(pos.x, pos.y, pos.z, true, 0.5)
            end
        end
    end)
end

local function make_waterfall(inst)
    local waterfall = SpawnPrefab("tbat_moonlit_memory_crystal_spring_waterfall")
    inst:AddChild(waterfall)
    waterfall.Transform:SetPosition(0, 0, 0)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    -- MakePondPhysics(inst, 1.95)

    inst.AnimState:SetBuild("tbat_moonlit_memory_crystal_spring")
    inst.AnimState:SetBank("tbat_moonlit_memory_crystal_spring")
    inst.AnimState:PlayAnimation("idle", true)
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(3)

    inst.MiniMapEntity:SetIcon("tbat_moonlit_memory_crystal_spring.tex")

    inst:AddTag("pond")
    inst:AddTag("antlion_sinkhole_blocker")
    inst:AddTag("birdblocker")

    inst.no_wet_prefix = true
    -- inst:SetDeploySmartRadius(2)

    inst.entity:SetPristine()
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")
    inst:AddComponent("lootdropper")

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(9)
    inst.components.workable:SetOnFinishCallback(function(inst, worker)
        inst.components.lootdropper:DropLoot()
        local fx = SpawnPrefab("collapse_big")
        fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
        fx:SetMaterial("metal")
        inst:Remove()
    end)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:WatchWorldState("isfullmoon", OnIsFullmoon)

    make_waterfall(inst)

    return inst
end

local function fn_waterfall()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("tbat_moonlit_memory_crystal_spring_waterfall")
    inst.AnimState:SetBuild("tbat_moonlit_memory_crystal_spring_waterfall")
    inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("NOBLOCK")
    inst:AddTag("NOCLICK")
    inst:AddTag("FX")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    return inst
end

return Prefab("tbat_moonlit_memory_crystal_spring", fn, assets, prefabs),
    Prefab("tbat_moonlit_memory_crystal_spring_waterfall", fn_waterfall, assets_waterfall, prefabs_waterfall),
    MakePlacer("tbat_moonlit_memory_crystal_spring_placer", "tbat_moonlit_memory_crystal_spring", "tbat_moonlit_memory_crystal_spring", "idle", true)
