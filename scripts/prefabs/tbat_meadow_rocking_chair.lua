local prefabs =
{
    "collapse_small",
    "tbat_meadow_rocking_chair_back",
}

local function _PlayAnimation(inst, anim, loop)
    inst.AnimState:PlayAnimation(anim, loop)
    if inst.back then
        inst.back.AnimState:PlayAnimation(anim, loop)
    end
end

local function _PushAnimation(inst, anim, loop)
    inst.AnimState:PushAnimation(anim, loop)
    if inst.back then
        inst.back.AnimState:PushAnimation(anim, loop)
    end
end

local function _AnimSetTime(inst, t)
    inst.AnimState:SetTime(t)
    if inst.back then
        inst.back.AnimState:SetTime(t)
    end
end

local function OnHit(inst, worker, workleft, numworks)
    if not inst:HasTag("burnt") then
        _PlayAnimation(inst, "hit")
        _PushAnimation(inst, "idle", false)
        inst.components.sittable:EjectOccupier()
    end
end

local function OnHammered(inst, worker)
    local collapse_fx = SpawnPrefab("collapse_small")
    collapse_fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    collapse_fx:SetMaterial("wood")

    inst.components.lootdropper:DropLoot()

    inst:Remove()
end

local function OnBuilt(inst, data)
    _PlayAnimation(inst, "place")
    _PushAnimation(inst, "idle", false)

    inst.SoundEmitter:PlaySound("dontstarve/common/repair_stonefurniture")

    local builder = (data and data.builder) or nil
    TheWorld:PushEvent("CHEVO_makechair", { target = inst, doer = builder })
end

local function CancelSitterAnimOver(inst)
    if inst._onsitteranimover then
        inst:RemoveEventCallback("animover", inst._onsitteranimover, inst._onsitteranimover_sitter)
        inst._onsitteranimover = nil
        inst._onsitteranimover_sitter = nil
    end
end

local ROCKING_ANIMS = { "rocking", "rocking_smile", "rocking_hat" }
local function IsSitterRockingPre(inst, sitter)
    for i, v in ipairs(ROCKING_ANIMS) do
        if sitter.AnimState:IsCurrentAnimation(v .. "_pre") then
            return true
        end
    end

    return false
end

local function IsSitterRockingLoop(inst, sitter)
    for i, v in ipairs(ROCKING_ANIMS) do
        if sitter.AnimState:IsCurrentAnimation(v .. "_loop") then
            return true
        end
    end

    return false
end

local function OnSyncChairRocking(inst, sitter)
    if inst.components.sittable:IsOccupiedBy(sitter) then
        if IsSitterRockingPre(inst, sitter) then
            _PlayAnimation(inst, "rocking_pre")
            local t = sitter.AnimState:GetCurrentAnimationTime()
            local len = inst.AnimState:GetCurrentAnimationLength()
            if t < len then
                _AnimSetTime(inst, t)
                _PushAnimation(inst, "rocking_loop")
            else
                _PlayAnimation(inst, "rocking_loop", true)
                _AnimSetTime(inst, t - len)
            end
            CancelSitterAnimOver(inst)
        elseif IsSitterRockingLoop(inst, sitter) then
            _PlayAnimation(inst, "rocking_loop", true)
            _AnimSetTime(inst, sitter.AnimState:GetCurrentAnimationTime())
            CancelSitterAnimOver(inst)
        elseif sitter.AnimState:IsCurrentAnimation("sit_off") then
            CancelSitterAnimOver(inst)
        elseif sitter.AnimState:IsCurrentAnimation("sit_jump_off") then
            _PlayAnimation(inst, "rocking_pst")
            _PushAnimation(inst, "idle", false)
            CancelSitterAnimOver(inst)
        else
            if sitter.AnimState:IsCurrentAnimation("sit_loop_pre") then
                _PlayAnimation(inst, "rocking_pst")
                _PushAnimation(inst, "idle", false)
            elseif inst.AnimState:IsCurrentAnimation("rocking_pre") or
                inst.AnimState:IsCurrentAnimation("rocking_loop") or
                sitter.AnimState:IsCurrentAnimation("sit_item_out") or
                sitter.AnimState:IsCurrentAnimation("sit_item_hat") then
                _PlayAnimation(inst, "idle")
            end
            if sitter ~= inst._onsitteranimover_sitter then
                CancelSitterAnimOver(inst)
                inst._onsitteranimover = function(_sitter) OnSyncChairRocking(inst, _sitter) end
                inst._onsitteranimover_sitter = sitter
                inst:ListenForEvent("animover", inst._onsitteranimover, sitter)
            end
        end
    end
end

local function OnBecomeSittable(inst)
    if inst.AnimState:IsCurrentAnimation("rocking_loop") then
        _PlayAnimation(inst, "rocking_pst")
        _PushAnimation(inst, "idle", false)
    elseif inst.AnimState:IsCurrentAnimation("rocking_pre") then
        _PlayAnimation(inst, "idle")
    end
    CancelSitterAnimOver(inst)
end

local ret = {}

local assets =
{
    Asset("ANIM", "anim/tbat_meadow_rocking_chair.zip"),
}

local function OnBackReplicated(inst)
    local parent = inst.entity:GetParent()
    if parent ~= nil and (parent.prefab == inst.prefab:sub(1, -6)) then
        parent.highlightchildren = { inst }
    end
end

local function backfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.Transform:SetNoFaced()

    inst:AddTag("FX")

    inst.AnimState:SetBank("tbat_meadow_rocking_chair")
    inst.AnimState:SetBuild("tbat_meadow_rocking_chair")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetFinalOffset(3)
    inst.AnimState:Hide("parts")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = OnBackReplicated

        return inst
    end

    inst.persists = false

    return inst
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    -- inst:SetDeploySmartRadius(1)

    -- MakeObstaclePhysics(inst, 0.25)

    inst.Transform:SetNoFaced()

    inst:AddTag("structure")
    inst:AddTag("limited_chair")
    inst:AddTag("rocking_chair")

    inst.AnimState:SetBank("tbat_meadow_rocking_chair")
    inst.AnimState:SetBuild("tbat_meadow_rocking_chair")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetFinalOffset(-1)
    inst.AnimState:Hide("back_over")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.back = SpawnPrefab("tbat_meadow_rocking_chair_back")
    inst.back.entity:SetParent(inst.entity)
    inst.highlightchildren = { inst.back }

    inst.scrapbook_facing = FACING_DOWN

    inst:AddComponent("inspectable")

    inst:AddComponent("lootdropper")

    inst:AddComponent("sittable")

    inst:AddComponent("savedrotation")
    inst.components.savedrotation.dodelayedpostpassapply = true

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(9)
    inst.components.workable:SetOnWorkCallback(OnHit)
    inst.components.workable:SetOnFinishCallback(OnHammered)

    inst:ListenForEvent("onbuilt", OnBuilt)

    inst:ListenForEvent("ms_sync_chair_rocking", OnSyncChairRocking)
    inst:ListenForEvent("becomesittable", OnBecomeSittable)

    MakeHauntableWork(inst)

    return inst
end

table.insert(ret, Prefab("tbat_meadow_rocking_chair_back", backfn, assets))
table.insert(ret, Prefab("tbat_meadow_rocking_chair", fn, assets, prefabs))
table.insert(ret, MakePlacer("tbat_meadow_rocking_chair_placer", "tbat_meadow_rocking_chair", "tbat_meadow_rocking_chair", "idle", nil, nil, nil, nil, 15, "four"))

return unpack(ret)
