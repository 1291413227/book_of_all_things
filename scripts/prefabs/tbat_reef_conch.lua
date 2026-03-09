local assets =
{
    Asset("ANIM", "anim/tbat_reef_conch.zip"),
}

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("tbat_reef_conch")
    inst.AnimState:SetBuild("tbat_reef_conch")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("meat")
    inst:AddTag("tbat_reef_conch")

    MakeInventoryFloatable(inst, "small", 0.15)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("edible")
    inst.components.edible.ismeat = true
    inst.components.edible.foodtype = FOODTYPE.MEAT
    inst.components.edible.healthvalue = 2
    inst.components.edible.hungervalue = 8
    inst.components.edible.sanityvalue = 2

    inst:AddComponent("bait")

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("tradable")
    inst.components.tradable.goldvalue = 0

    inst:AddComponent("perishable")
    inst.components.perishable:SetPerishTime(TUNING.PERISH_FASTISH) -- 8天
    inst.components.perishable:StartPerishing()
    inst.components.perishable.onperishreplacement = "spoiled_food"

    MakeHauntableLaunchAndPerish(inst)

    return inst
end

return Prefab("tbat_reef_conch", fn, assets)
