require("prefabutil")

local assets =
{
    Asset("ANIM", "anim/tbat_rose_twin_goose.zip"),
}

local prefabs =
{
    "collapse_small",
}

local TWIN_GOOSE_MAX_LEVEL = 2
local TWIN_GOOSE_MAX_EXP = 99
local TWIN_GOOSE_LEVEL2_TAG = "tbat_rose_twin_goose_2"

local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("stone")
    inst:Remove()
end

local function OnHit(inst, worker)
    if inst.components.container_proxy ~= nil then
        inst.components.container_proxy:Close()
    end
end

local function FindTwinGooseEntity(exclude_inst)
    for _, ent in pairs(Ents) do
        if ent ~= exclude_inst and ent.prefab == "tbat_rose_twin_goose" and ent:IsValid() then
            return ent
        end
    end
end

local function AttachContainer(inst)
    inst.components.container_proxy:SetMaster(TheWorld:GetPocketDimensionContainer("tbat_rose_twin_goose"))
end

local function RefreshWorldTwinGooseState()
    if TheWorld == nil then
        return nil
    end

    if TheWorld._tbat_refresh_twin_goose_state ~= nil then
        return TheWorld._tbat_refresh_twin_goose_state(TheWorld)
    end

    return FindTwinGooseEntity()
end

local function ClampTwinGooseLevel(level)
    level = math.floor(tonumber(level) or 1)
    if level < 1 then
        return 1
    elseif level > TWIN_GOOSE_MAX_LEVEL then
        return TWIN_GOOSE_MAX_LEVEL
    end

    return level
end

local function ClampTwinGooseExp(exp)
    exp = math.floor(tonumber(exp) or 0)
    if exp < 0 then
        return 0
    elseif exp > TWIN_GOOSE_MAX_EXP then
        return TWIN_GOOSE_MAX_EXP
    end

    return exp
end

local function GetTwinGooseLevel(inst)
    return ClampTwinGooseLevel(inst.tbat_level or 1)
end

local function GetTwinGooseExp(inst)
    if GetTwinGooseLevel(inst) >= TWIN_GOOSE_MAX_LEVEL then
        return TWIN_GOOSE_MAX_EXP
    end

    return ClampTwinGooseExp(inst.tbat_exp or 0)
end

local function ApplyTwinGooseProgress(inst, level, exp)
    level = ClampTwinGooseLevel(level)
    exp = ClampTwinGooseExp(exp)

    if level >= TWIN_GOOSE_MAX_LEVEL or exp >= TWIN_GOOSE_MAX_EXP then
        level = TWIN_GOOSE_MAX_LEVEL
        exp = TWIN_GOOSE_MAX_EXP
    end

    inst.tbat_level = level
    inst.tbat_exp = exp

    if level >= TWIN_GOOSE_MAX_LEVEL then
        if not inst:HasTag(TWIN_GOOSE_LEVEL2_TAG) then
            inst:AddTag(TWIN_GOOSE_LEVEL2_TAG)
            inst.AnimState:PlayAnimation("grow")
            inst.AnimState:PushAnimation("idle2", true)
            inst.components.prototyper.trees = TUNING.PROTOTYPER_TREES.TBAT_TWIN_GOOSE_TECH_ONE
        end
    elseif inst:HasTag(TWIN_GOOSE_LEVEL2_TAG) then
        inst:RemoveTag(TWIN_GOOSE_LEVEL2_TAG)
    end

    if TheWorld ~= nil and TheWorld.ismastersim and TheWorld._tbat_rose_twin_goose == inst then
        RefreshWorldTwinGooseState()
    end
end

local function SetTwinGooseExp(inst, exp)
    ApplyTwinGooseProgress(inst, inst.tbat_level or 1, exp)
end

local function AddTwinGooseExp(inst, exp)
    exp = tonumber(exp) or 0
    if exp ~= 0 then
        ApplyTwinGooseProgress(inst, inst.tbat_level or 1, (inst.tbat_exp or 0) + exp)
    end
end

local function RegisterTwinGoose(inst)
    local world = TheWorld
    if world == nil then
        return true
    end

    local goose = FindTwinGooseEntity(inst) or RefreshWorldTwinGooseState()
    if goose ~= nil and goose ~= inst then
        inst:DoTaskInTime(0, function()
            if inst:IsValid() then
                inst:Remove()
            end
        end)
        return false
    end

    world._tbat_rose_twin_goose = inst
    RefreshWorldTwinGooseState()

    return true
end

local function OnRemoveEntity(inst)
    local world = TheWorld
    if world == nil or not world:IsValid() then
        return
    end

    if world._tbat_rose_twin_goose == inst then
        world._tbat_rose_twin_goose = nil
    end

    RefreshWorldTwinGooseState()
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
    inst.AnimState:PlayAnimation("idle1", true)

    inst:AddComponent("container_proxy")

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
    inst.components.workable:SetOnWorkCallback(OnHit)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst.GetTwinGooseLevel = GetTwinGooseLevel
    inst.GetTwinGooseExp = GetTwinGooseExp
    inst.SetTwinGooseExp = SetTwinGooseExp
    inst.AddTwinGooseExp = AddTwinGooseExp
    ApplyTwinGooseProgress(inst, 1, 0)

    if not RegisterTwinGoose(inst) then
        return inst
    end

    inst.OnSave = function(_inst, data)
        data.tbat_level = inst:GetTwinGooseLevel()
        data.tbat_exp = inst:GetTwinGooseExp()
    end
    inst.OnLoad = function(_inst, data)
        ApplyTwinGooseProgress(
            inst,
            data ~= nil and data.tbat_level or 1,
            data ~= nil and data.tbat_exp or 0
        )
    end
    inst.OnRemoveEntity = OnRemoveEntity
    inst.OnLoadPostPass = AttachContainer

    if not POPULATING then
        AttachContainer(inst)
    end

    return inst
end

return Prefab("tbat_rose_twin_goose", fn, assets, prefabs),
    MakePlacer("tbat_rose_twin_goose_placer", "tbat_rose_twin_goose", "tbat_rose_twin_goose", "idle1")
