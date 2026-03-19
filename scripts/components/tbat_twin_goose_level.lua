local function ClampLevel(level)
    level = math.floor(tonumber(level) or 0)
    if level < 0 then
        return 0
    elseif level > 2 then
        return 2
    end
    return level
end

return Class(function(self, inst)
    self.inst = inst

    local world = TheWorld
    local ismastersim = world ~= nil and world.ismastersim or false
    local level = net_smallbyte(inst.GUID, "tbat_twin_goose_level.level", "tbat_twin_goose_leveldirty")

    local function PushLevelDirty()
        if world ~= nil and world:IsValid() then
            world:PushEvent("tbat_level_change", { level = level:value() or 0 })
        end
    end

    function self:GetLevel()
        return level:value() or 0
    end

    if ismastersim then
        function self:SetLevel(new_level, force_dirty)
            new_level = ClampLevel(new_level)
            if force_dirty then
                level:set_local(new_level)
            end
            level:set(new_level)
            return new_level
        end
    end

    -- Keep a deterministic local default until server data arrives.
    level:set(0)

    inst:ListenForEvent("tbat_twin_goose_leveldirty", PushLevelDirty)
    inst:ListenForEvent("playeractivated", PushLevelDirty, world)
    PushLevelDirty()
end)
