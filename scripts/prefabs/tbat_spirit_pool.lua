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

local function SayToFisherman(inst, message)
    local fisherman = inst.tbat_fisherman
    if fisherman ~= nil and fisherman.components.talker ~= nil then
        fisherman:DoTaskInTime(20 * FRAMES, function(doer)
            if doer ~= nil and doer:IsValid() and doer.components.talker ~= nil then
                doer.components.talker:Say(message)
            end
        end)
    end
end

local function ConsumeBait(container, bait)
    if bait == nil then
        return false
    end

    if bait.components.stackable ~= nil then
        local consumed = bait.components.stackable:Get(1)
        if consumed ~= nil then
            consumed:Remove()
            return true
        end
        return false
    end

    local consumed = container:RemoveItem(bait, false)
    if consumed ~= nil then
        consumed:Remove()
        return true
    end

    return false
end

local function GetFishFn(inst)
    local container = inst.components.container
    if container == nil then
        return "weregoose_splash_med2" -- 钓上去一个特效，哈哈
    end

    if inst.tbat_fishingrod == nil or inst.tbat_fisherman == nil then
        return "weregoose_splash_med2"
    end

    if inst.tbat_fishingrod ~= "tbat_eq_fantasy_tool" then
        SayToFisherman(inst, "我大概需要一个美貌与实用并存的工具")
        return "weregoose_splash_med2"
    end

    local bait = container:GetItemInSlot(5)
    if bait == nil then
        SayToFisherman(inst, "没有诱饵，我不是姜太公")
        return "weregoose_splash_med2"
    end

    local fishslots = { 1, 2, 3, 4, 6, 7, 8, 9 }
    local slot = fishslots[math.random(#fishslots)]
    local fishitem = container:GetItemInSlot(slot)

    if fishitem == nil then
        SayToFisherman(inst, "没有饲养鱼或饲养鱼太少")
        return "weregoose_splash_med2"
    end

    local pool = inst.components.tbat_pool
    if pool ~= nil and not pool:CanFish(inst.tbat_fisherman) then
        SayToFisherman(inst, "别钓了，小鱼还没长大呢，明天在试试吧~")
        return "weregoose_splash_med2"
    end

    if not ConsumeBait(container, bait) then
        SayToFisherman(inst, "没有诱饵，我不是姜太公")
        return "weregoose_splash_med2"
    end

    if pool ~= nil and not pool:ConsumeFishingChance(inst.tbat_fisherman) then
        SayToFisherman(inst, "别钓了，小鱼还没长大呢，明天在试试吧~")
        return "weregoose_splash_med2"
    end

    return fishitem.prefab
end

local function getstacksize(item)
    if item == nil then
        return 0
    end

    return item.components.stackable ~= nil and item.components.stackable:StackSize() or 1
end

local function SalvageFn(inst, doer)
    local container = inst.components.container
    local inventory = doer.components.inventory or nil
    if container == nil or inventory == nil then
        return false
    end

    local fishslots = { 1, 2, 3, 4, 6, 7, 8, 9 }
    local speciesmap = {}  -- 品种映射表
    local specieslist = {} -- 品种列表

    for _, slot in ipairs(fishslots) do
        local fish = container:GetItemInSlot(slot)
        if fish ~= nil then
            local species = speciesmap[fish.prefab]
            if species == nil then
                species = { prefab = fish.prefab }
                speciesmap[fish.prefab] = species
                table.insert(specieslist, species)
            end
        end
    end

    if #specieslist <= 0 then
        return false, "NO_FISH"
    end

    local bait = container:GetItemInSlot(5)
    if bait == nil then
        return false, "NO_BAIT"
    end

    local salvagecount = math.min(5, #specieslist) -- 打捞数量,最多5种
    local baitcost = salvagecount * 2
    -- 饵料不足
    if getstacksize(bait) < baitcost then
        return false, "NO_BAIT"
    end

    -- 品种大于最多打捞数量时随机排序品种列表,保证每种品种被打捞的概率相同
    if #specieslist > salvagecount then
        for i = #specieslist, 2, -1 do
            local j = math.random(i)
            specieslist[i], specieslist[j] = specieslist[j], specieslist[i]
        end
    end

    local actualcount = 0
    for i = 1, salvagecount do
        local species = specieslist[i]
        local reward = SpawnPrefab(species.prefab)

        if reward ~= nil then
            inventory:GiveItem(reward, nil, inst:GetPosition())
            actualcount = actualcount + 1
        end
    end

    if actualcount <= 0 then
        return false, "NO_FISH"
    end

    baitcost = actualcount * 2
    bait = container:GetItemInSlot(5)
    if bait ~= nil then
        if bait.components.stackable ~= nil and bait.components.stackable:StackSize() > baitcost then
            local consumed = bait.components.stackable:Get(baitcost)
            if consumed ~= nil then
                consumed:Remove()
            end
        else
            local consumed = container:RemoveItem(bait, false)
            if consumed ~= nil then
                consumed:Remove()
            end
        end
    end

    return true
end

local function set_container(inst)
    local num = inst._container:value()
    if num == 1 then
        inst.replica.container:WidgetSetup("tbat_spirit_pool_hnct")
    else
        inst.replica.container:WidgetSetup("tbat_spirit_pool")
    end
end

local function commonfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakePondPhysics(inst, 2.1)

    inst.AnimState:SetBuild("tbat_spirit_pool")
    inst.AnimState:SetBank("tbat_spirit_pool")
    inst.AnimState:PlayAnimation("idle", true)
    -- inst.AnimState:SetLayer(LAYER_BACKGROUND)
    -- inst.AnimState:SetSortOrder(3)

    -- inst.Transform:SetScale(0.5, 0.5, 1)

    inst.MiniMapEntity:SetIcon("tbat_spirit_pool.tex")

    inst:AddTag("watersource")              -- 水源
    inst:AddTag("pond")
    inst:AddTag("antlion_sinkhole_blocker") -- 不受蚁狮地震影响
    inst:AddTag("birdblocker")              -- 鸟不会停留在池塘上
    inst:AddTag("tbat_pool")                -- 幻灵水池标签

    inst.no_wet_prefix = true               -- 没有潮湿的前缀

    inst:SetDeploySmartRadius(2.5)

    inst._container = net_smallbyte(inst.GUID, "tbat_spirit_pool._container", "tbat_container_change") -- 设置本地参数监听值

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst:ListenForEvent("tbat_container_change", set_container)
        return inst
    end

    inst._container:set(0)

    inst:AddComponent("inspectable")

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("tbat_spirit_pool")

    inst:AddComponent("preserver")
    inst.components.preserver:SetPerishRateMultiplier(TUNING.FISH_BOX_PRESERVER_RATE)

    inst:AddComponent("fishable")
    inst.components.fishable:SetGetFishFn(GetFishFn)

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(9)
    inst.components.workable:SetOnFinishCallback(onhammered)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:AddComponent("watersource")

    inst:AddComponent("tbat_pool") -- 幻灵水池打捞组件
    inst.components.tbat_pool:SetSalvageFn(SalvageFn)

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
