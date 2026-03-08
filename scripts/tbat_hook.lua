-- ================================================================
--[[给幻灵水池容器做特殊处理,实现特殊槽位多slots]]
-- ================================================================
local TARGET_CONTAINER_PREFAB = "tbat_spirit_pool" -- 仅干预自己mod的容器,避免和其他mod冲突

local function IsTargetContainer(self, item)
    return self.inst ~= nil
        and self.inst.prefab == TARGET_CONTAINER_PREFAB
end

local function GetStackable(item)
    if item == nil then
        return nil
    end

    return (item.components ~= nil and item.components.stackable)
        or (item.replica ~= nil and item.replica.stackable)
        or nil
end

local function FindFirstAvailableSpecificSlot(self, item)
    local empty_slot = nil

    for i = 1, self:GetNumSlots() do
        if self:itemtestfn(item, i) then
            local slot_item = self:GetItemInSlot(i)
            if slot_item == nil then
                empty_slot = empty_slot or i
            elseif self:AcceptsStacks()
                and slot_item.prefab == item.prefab
                and slot_item.skinname == item.skinname then
                local stackable = GetStackable(slot_item)
                if stackable ~= nil and not stackable:IsFull() then
                    return i
                end
            end
        end
    end

    return empty_slot
end

local Container = require("components/container")
if not Container._tbat_specific_slot_hooked then
    Container._tbat_specific_slot_hooked = true

    local _GetSpecificSlotForItem = Container.GetSpecificSlotForItem
    function Container:GetSpecificSlotForItem(item, ...)
        if not IsTargetContainer(self, item) then
            return _GetSpecificSlotForItem(self, item, ...)
        end

        return FindFirstAvailableSpecificSlot(self, item)
    end
end

local ContainerReplica = require("components/container_replica")
if not ContainerReplica._tbat_specific_slot_hooked then
    ContainerReplica._tbat_specific_slot_hooked = true

    local _GetSpecificSlotForItem = ContainerReplica.GetSpecificSlotForItem
    function ContainerReplica:GetSpecificSlotForItem(item, ...)
        if not IsTargetContainer(self, item) then
            return _GetSpecificSlotForItem(self, item, ...)
        end

        return FindFirstAvailableSpecificSlot(self, item)
    end
end

-- ================================================================
--[[给幻灵水池的鱼池组件做特殊处理]]
-- ================================================================
local Fishable = require("components/fishable")
local _HookFish = Fishable.HookFish
-- 剩余鱼数量始终在最大值
function Fishable:HookFish(fisherman, ...)
    if self.inst ~= nil and self.inst.prefab == TARGET_CONTAINER_PREFAB then
        -- 让幻灵水池的鱼池组件在被钓鱼杆钓到时也能正常工作
        local fish = _HookFish(self, fisherman, ...)
        if fish.build == nil then
            fish.build = "000"
        end
        self.fishleft = self.maxfish or 10
        return fish
    end

    return _HookFish(self, fisherman, ...)
end

-- ================================================================
--[[钓竿组件特殊处理，好复杂。。。]]
-- ================================================================
local FishingRod = require("components/fishingrod")
local _OnUpdate = FishingRod.OnUpdate
local _StopFishing = FishingRod.StopFishing
local _Hook = FishingRod.Hook
function FishingRod:OnUpdate(dt, ...)
    if self:IsFishing() and self.target and self.target.prefab == TARGET_CONTAINER_PREFAB then
        self.target.components.container.canbeopened = false
    end
    _OnUpdate(self, dt, ...)
end

function FishingRod:StopFishing(...)
    if self.target and self.target.prefab == TARGET_CONTAINER_PREFAB then
        self.target.components.container.canbeopened = true
    end
    _StopFishing(self, ...)
end

-- 这样多人钓鱼的时候应该不会彼此覆盖吧,有待实装验证
function FishingRod:Hook(...)
    self.target.fisherman = self.fisherman
    self.target.fishingrod = self.inst.prefab
    _Hook(self, ...)
    self.target.fisherman = nil
    self.target.fishingrod = nil
end
