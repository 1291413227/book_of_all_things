local assets =
{
    Asset("ANIM", "anim/tbat_rose_goose_egg.zip"),
}

local function RefreshTwinGooseState(inst, data)
    local world = TheWorld
    if world == nil or not world:IsValid() then
        return
    end

    local container_proxy = inst.components.container_proxy
    if container_proxy == nil then
        return
    end

    local level = world.GetTBATTwinGooseLevel ~= nil and world:GetTBATTwinGooseLevel() or 0
    if level < 2 then
        inst.components.container_proxy:SetCanBeOpened(false)
    else
        inst.components.container_proxy:SetCanBeOpened(true)
    end
end

local function AttachContainer(inst)
    inst.components.container_proxy:SetMaster(TheWorld:GetPocketDimensionContainer("tbat_rose_twin_goose"))
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("tbat_rose_goose_egg")
    inst.AnimState:SetBuild("tbat_rose_goose_egg")
    inst.AnimState:PlayAnimation("idle")

    inst:AddComponent("container_proxy")

    inst:AddTag("tbat_rose_goose_egg")

    MakeInventoryFloatable(inst, "small", 0.15)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")

    MakeHauntablePerish(inst)

    inst.OnLoadPostPass = AttachContainer

    if not POPULATING then
        AttachContainer(inst)
    end

    inst:ListenForEvent("tbat_refresh_twin_goose_state",
        function()
            RefreshTwinGooseState(inst)
        end, TheWorld)
    RefreshTwinGooseState(inst)

    return inst
end

return Prefab("tbat_rose_goose_egg", fn, assets)
