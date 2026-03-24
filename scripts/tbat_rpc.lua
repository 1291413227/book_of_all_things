local DEFAULT_CHAT_NAME_COLOUR = { 118 / 255, 89 / 255, 141 / 255, 1 }
local DEFAULT_CHAT_MESSAGE_COLOUR = { 1, 1, 1, 1 }

local function FormatChatMessage(message, show_realtime)
    if message == nil or not show_realtime then
        return message
    end

    local ok, timestr = pcall(os.date, "%H:%M:%S")
    if ok and timestr ~= nil and timestr ~= "" then
        return string.format("[%s] %s", timestr, message)
    end

    return message
end

-- 客户端触发聊天栏显示消息
AddClientModRPCHandler("BOOKOFALLTHINGS", "ChatMessage", function(sender_name, message, icon, iconbg, show_realtime)
    if ChatHistory == nil or ChatTypes == nil or message == nil then
        return
    end

    local colour = {
        DEFAULT_CHAT_MESSAGE_COLOUR[1],
        DEFAULT_CHAT_MESSAGE_COLOUR[2],
        DEFAULT_CHAT_MESSAGE_COLOUR[3],
        DEFAULT_CHAT_MESSAGE_COLOUR[4],
    }
    colour.name_colour = {
        DEFAULT_CHAT_NAME_COLOUR[1],
        DEFAULT_CHAT_NAME_COLOUR[2],
        DEFAULT_CHAT_NAME_COLOUR[3],
        DEFAULT_CHAT_NAME_COLOUR[4],
    }

    ChatHistory:AddToHistory(
        ChatTypes.ChatterMessage,
        nil,
        nil,
        sender_name or "None",
        FormatChatMessage(message, show_realtime),
        colour,
        { icon = icon, iconbg = iconbg },
        nil,
        true
    )
end)

-- 关闭容器
AddModRPCHandler("BOOKOFALLTHINGS", "Closecontainer", function(player, container)
    if container.components.container:IsOpenedBy(player) then
        container.components.container:Close(player)
        player:PushEvent("closecontainer", { container = container })
    end
end)

AddModRPCHandler("BOOKOFALLTHINGS", "Changecontainer", function(operate_player, container, container_name)
    if container.components.container:IsOpenedBy(operate_player) then
        local other_container = container.tbat_openlist[operate_player]
        if other_container == nil then
            return
        end
        for player, open_container in pairs(container.tbat_openlist) do
            if open_container == other_container then
                container.components.container:Close(player)
                player:PushEvent("closecontainer", { container = container })
                other_container.components.container_proxy:SetMaster(TheWorld:GetPocketDimensionContainer(container_name))
                other_container.components.container_proxy:Open(player)
                player:PushEvent("opencontainer", { container = other_container.components.container_proxy:GetMaster() })
            end
        end
    end
end)

local function add(item, needed_count)
    if item.components.finiteuses then
        local now_percent = item.components.finiteuses:GetPercent()
        local new_percent = math.min(3, now_percent + 0.2)
        item.components.finiteuses:SetPercent(new_percent)
    elseif item.components.armor then
        local now_percent = item.components.armor:GetPercent()
        local new_percent = math.min(3, now_percent + 0.2)
        item.components.armor:SetPercent(new_percent)
    elseif item.prefab == "tbat_material_lavender_laundry_detergent" then
        item.components.stackable:Get(needed_count):Remove()
    end
end

local function reduce(item, needed_count)
    if item.components.finiteuses then
        local now_percent = item.components.finiteuses:GetPercent()
        local new_percent = math.max(0, now_percent - 0.2)
        item.components.finiteuses:SetPercent(new_percent)
    elseif item.components.armor then
        local now_percent = item.components.armor:GetPercent()
        local new_percent = math.max(0, now_percent - 0.2)
        item.components.armor:SetPercent(new_percent)
    elseif item.prefab == "tbat_material_lavender_laundry_detergent" then
        item.components.stackable:Get(needed_count):Remove()
    end
end

-- 萌宠洗衣机触发工作的服务端逻辑
AddModRPCHandler("BOOKOFALLTHINGS", "UsePetWasher", function(player, container, status)
    if container.components.container:IsOpenedBy(player) then
        container.components.container:Close(player)
        player:PushEvent("closecontainer", { container = container })
    end
    local ok, count = container.components.container:Has("tbat_material_lavender_laundry_detergent", 5)
    if not ok then
        container.components.talker:Say("当前洗衣液不够洗这么多衣服，请在拿一点给我吧~")
        return
    end
    local num_items = container.components.container:NumItems() - 1
    if num_items <= 0 then
        container.components.talker:Say("没东西可以洗哦~")
        return
    end
    local needed_count = num_items * 5
    if count < needed_count then
        container.components.talker:Say("当前洗衣液不够洗这么多衣服，请在拿一点给我吧~")
        return
    end

    if container.StartTBATWork ~= nil and not container:StartTBATWork(player) then
        return
    end

    if status == "add" then
        container.components.container:ForEachItem(add, needed_count)
    elseif status == "reduce" then
        container.components.container:ForEachItem(reduce, needed_count)
    end
end)
