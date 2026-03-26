local need_lock_skin = {
    ["142"] = "tbat_vine_current",
    ["143"] = "tbat_vine_dreamcatcher",
}

-- 限定皮肤，vip(白名单)不添加到解锁列表
local limit_skin = {
    -- "5",
}

local auth_caches = {}

-- SORTED_IDS表就是皮肤编号排序。举例：{201, 202}
local function sorted_skin_ids()
    local ids = {}
    for id in pairs(need_lock_skin) do
        ids[#ids + 1] = tonumber(id)
    end
    table.sort(ids)
    return ids
end
local SORTED_IDS = sorted_skin_ids()

-- 把皮肤代码和皮肤编号反过来，生成一个从皮肤代码到编号的表。举例：{["tbat_vine_current"] = 201, ["tbat_vine_dreamcatcher"] = 202}
local SKIN_TO_ID = {}
for id, code in pairs(need_lock_skin) do
    if SKIN_TO_ID[code] == nil then
        SKIN_TO_ID[code] = id
    end
end

-- 判断一个列表里是否包含某个值
local function table_contains(list, value)
    for _, item in pairs(list or {}) do
        if item == value then
            return true
        end
    end
    return false
end

-- vip(白名单)添加非限制皮肤到解锁列表
local function vip_expand(info)
    for _, id_num in ipairs(SORTED_IDS) do
        local id = tostring(id_num)
        local skincode = need_lock_skin[id]
        if not table_contains(limit_skin, id) and not table_contains(info, skincode) then
            info[#info + 1] = skincode
        end
    end
end

-- 压缩的皮肤添加到解锁列表
local function hex_to_index_array(hex_string)
    local hex_to_bin_map = {
        ["0"] = "0000",
        ["1"] = "0001",
        ["2"] = "0010",
        ["3"] = "0011",
        ["4"] = "0100",
        ["5"] = "0101",
        ["6"] = "0110",
        ["7"] = "0111",
        ["8"] = "1000",
        ["9"] = "1001",
        ["a"] = "1010",
        ["b"] = "1011",
        ["c"] = "1100",
        ["d"] = "1101",
        ["e"] = "1110",
        ["f"] = "1111",
        ["A"] = "1010",
        ["B"] = "1011",
        ["C"] = "1100",
        ["D"] = "1101",
        ["E"] = "1110",
        ["F"] = "1111",
    }

    local binary_string = ""
    for i = 1, #hex_string do
        local char = hex_string:sub(i, i)
        local binary = hex_to_bin_map[char]
        if not binary then
            return {}
        end
        binary_string = binary_string .. binary
    end

    local start_pos = binary_string:find("1", 1, true)
    if not start_pos then
        return {}
    end

    binary_string = binary_string:sub(start_pos + 1)
    local result = {}
    for i = 1, #binary_string do
        result[#result + 1] = binary_string:sub(i, i)
    end
    return result
end

local function hex_expand(info, hex_value)
    local result = hex_to_index_array(hex_value)
    -- for i, v in pairs(result) do
    --     print("hex expand", i, v)
    -- end
    for index, flag in ipairs(result) do
        if flag == "1" and need_lock_skin[tostring(index)] and not table_contains(info, need_lock_skin[tostring(index)]) then
            info[#info + 1] = need_lock_skin[tostring(index)]
        end
    end
end

local keys = {
    ["1"] = "F3dHus5U01yPHK3g5PzKr1cXcnd97e5o",
    ["2"] = "hYBiIjohyDl1B5fu7VrS77Ul6Kzq1gaG",
    ["3"] = "1jf9DBGSu5xsCdzmZPNT9DhTuEs8fKHn",
    ["4"] = "ENKCDfxnCVSlMftvSU4YLIhHjrqluAsm",
    ["5"] = "ptkJsz2JOYn6180Ro9BVsR4B0hcffiSq",
    ["6"] = "keSiKkZF45iOfGHiQ3Y8kxHmV15laVUj",
    ["7"] = "DAWRXWBPPD7wCyVtxhz5xxP6XiyVAPoq",
    ["8"] = "fWm9HblPYl2u6Yi7TBD7HfnqAeH7eQxD",
    ["9"] = "N3pArHbzKevd22yCzmzuQLx3f9DWx2gx",
}

-- Base64字符表
local base64_chars = {
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P",
    "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f",
    "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v",
    "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "+", "/",
}
local reverse_chars = {}
for i, v in ipairs(base64_chars) do
    reverse_chars[v] = i - 1
end
reverse_chars["="] = 0

-- 64进制解码
local function base64_decode(data)
    data = data:gsub("[^%w+/=]", "")
    local result = {}
    local i = 1

    while i <= #data do
        if data:sub(i, i) == "=" then
            break
        end

        local a = reverse_chars[data:sub(i, i)] or 0
        local b = reverse_chars[data:sub(i + 1, i + 1)] or 0
        local c = reverse_chars[data:sub(i + 2, i + 2)] or 0
        local d = reverse_chars[data:sub(i + 3, i + 3)] or 0

        local n = a * 0x40000 + b * 0x1000 + c * 0x40 + d
        local c1 = math.floor(n / 0x10000) % 0x100
        local c2 = math.floor(n / 0x100) % 0x100
        local c3 = n % 0x100

        result[#result + 1] = string.char(c1)
        if data:sub(i + 2, i + 2) ~= "=" then
            result[#result + 1] = string.char(c2)
        end
        if data:sub(i + 3, i + 3) ~= "=" then
            result[#result + 1] = string.char(c3)
        end

        i = i + 4
    end

    return table.concat(result)
end

-- 读取缓存文件里的cdk
local function get_cdk()
    local file = io.open("unsafedata/atbookdata.json")
    -- local file = io.open("mods/book_of_all_things/scripts/atbookdata.json", "r")
    if file then
        local content = file:read("*all")
        file:close()
        return content
    end
    return nil
end

-- XOR解密
local function bit_xor(a, b)
    local result = 0
    local bitval = 1
    while a > 0 or b > 0 do
        local a_bit = a % 2
        local b_bit = b % 2
        if a_bit ~= b_bit then
            result = result + bitval
        end
        a = math.floor(a / 2)
        b = math.floor(b / 2)
        bitval = bitval * 2
    end
    return result
end

local function crypt_core(input, key)
    if #key == 0 then
        return input
    end

    local key_bytes = { key:byte(1, #key) }
    local result = {}

    for i = 1, #input do
        local k = key_bytes[(i - 1) % #key_bytes + 1]
        local c = input:byte(i)
        result[i] = string.char(bit_xor(c, k))
    end

    return table.concat(result)
end

local function decrypt_body(ciphertext, key)
    return crypt_core(base64_decode(ciphertext), key)
end

-- 解密CDK
local function decrypt_cdk(cdk)
    if type(cdk) ~= "string" or #cdk < 2 then
        return nil, "cdk is too short"
    end

    local key_id = cdk:sub(1, 1)
    local key = keys[key_id]
    if not key then
        return nil, "unknown key id: " .. tostring(key_id)
    end

    local body = cdk:sub(2)
    local plaintext = decrypt_body(body, key)
    return {
        key_id = key_id,
        key = key,
        body = body,
        plaintext = plaintext,
    }
end

local function split_csv(input)
    local result = {}
    input = input .. ","
    for match in input:gmatch("(.-),") do
        if match ~= "" then
            result[#result + 1] = match
        end
    end
    return result
end

local function explain_decode(cdk, userid)
    local result, err = decrypt_cdk(cdk)
    if not result then
        print("decrypt failed:", err)
        return
    end
    -- print(result.plaintext)
    local stripped = result.plaintext:gsub("#", "")
    print("stripped:", stripped)
    local tokens = split_csv(stripped)
    -- for k, v in pairs(tokens) do
    --     print("token", k, ":", v)
    -- end
    local raw_skins = {}  -- 解锁皮肤列表
    local hex_tokens = {} -- 需要额外处理的hex token列表
    local id_match = false
    for _, token in ipairs(tokens) do
        -- 如果有一个token是VIP，就把非限制皮肤添加到raw_skins里
        if token == "VIP" then
            vip_expand(raw_skins)
        elseif token:sub(1, 1) == "&" then
            hex_tokens[#hex_tokens + 1] = token
            hex_expand(raw_skins, token:sub(2))
        elseif token:match("^KU_") or token:match("^OU_") then
            if userid and userid:match("^OU_") then
                token = userid -- 离线模式就放行吧
            end
            if userid == token then
                id_match = true
            end
        elseif need_lock_skin[tostring(token)] and not table_contains(raw_skins, need_lock_skin[tostring(token)]) then
            raw_skins[#raw_skins + 1] = need_lock_skin[tostring(token)]
        end
    end
    for k, v in pairs(raw_skins) do
        print("unlocked skin", k, ":", v)
    end
    return {
        id_match = id_match,
        skins = raw_skins,
    }
end

-- local cdk = get_cdk()
-- print("cdk from file:", cdk)

-- explain_decode(cdk, "KU_84TfuVxe")

-------------------------------------------------------------------------------
-- 玩家加载进世界后立刻同步数据
-------------------------------------------------------------------------------
local function EnsureWorldSkinData()
    if not TheWorld.tbat_skin_data then
        TheWorld.tbat_skin_data = {}
    end
end

local RPC_NAMESPACE = "BOOKOFALLTHINGS"
local RPC_NAME      = "sync_skin_data"

AddModRPCHandler(RPC_NAMESPACE, RPC_NAME, function(player, data_str)
    if not data_str or type(data_str) ~= "string" then
        return
    end

    local info = json.decode(data_str)
    if type(info) ~= "table"
        or type(info.userid) ~= "string"
        or type(info.skins) ~= "table" then
        return
    end

    EnsureWorldSkinData()
    TheWorld.tbat_skin_data[info.userid] = info
end)

-- 本地缓存加载
local function EnsureAuthLoaded(userid, force)
    -- 如果force为true，或者缓存里没有这个userid的数据，就从文件里加载并同步到服务器
    if auth_caches[userid] == nil or force then
        local cdk = get_cdk()
        if not cdk or cdk == "" then
            return
        end

        local decoded = explain_decode(cdk, userid)
        if decoded and decoded.id_match and type(decoded.skins) == "table" then
            auth_caches[userid] = decoded.skins
            -- 同步到服务端
            local data_str = json.encode({
                userid = userid,
                skins = decoded.skins,
            })
            SendModRPCToServer(GetModRPC("BOOKOFALLTHINGS", "sync_skin_data"), data_str)
        end
    end
end

AddClientModRPCHandler(RPC_NAMESPACE, "cdk_verify", function(player)
    EnsureAuthLoaded(player.userid, true)
end)

local function DelayEnsureAndSync(inst)
    -- 只在客户端执行
    if TheNet:IsDedicated() then
        return
    end

    if not ThePlayer then
        -- 理论不会出现，但防御一手
        inst:DoTaskInTime(2, DelayEnsureAndSync)
        return
    end

    local userid = ThePlayer.userid
    if not userid or userid == "" then
        -- userid 未初始化，延时再试
        ThePlayer:DoTaskInTime(2, DelayEnsureAndSync)
        return
    end

    -- 此时 userid 肯定 OK，执行本地加载与服务器同步
    EnsureAuthLoaded(userid, true)

    -- 再主动同步一次
    local cdk = get_cdk()
    if not cdk or cdk == "" then
        return
    end

    local decoded = explain_decode(cdk, userid)
    if decoded and decoded.id_match and type(decoded.skins) == "table" then
        auth_caches[userid] = decoded.skins
        local data_str = json.encode({
            userid = userid,
            skins = decoded.skins,
        })
        SendModRPCToServer(GetModRPC("BOOKOFALLTHINGS", "sync_skin_data"), data_str)
    end
end

AddPlayerPostInit(function(inst)
    -- 只在客户端 ThePlayer 上执行，防止所有玩家都触发
    if not TheNet:IsDedicated() then
        -- 延迟启动
        inst:DoTaskInTime(2, DelayEnsureAndSync)
    end
    if not TheWorld.ismastersim then
        return
    end
    inst:ListenForEvent("tbat_brcverify_success", function()
        SendModRPCToClient(CLIENT_MOD_RPC["BOOKOFALLTHINGS"]["cdk_verify"], inst.userid, inst)
    end)
end)

-------------------------------------------------------------------------------
-- 客机：检查是否拥有皮肤（给皮肤 bank 用）
-------------------------------------------------------------------------------
TbatSkinCheckFn = function(_, skinname)
    local player = ThePlayer
    if not player then return false end
    local uid = player.userid
    EnsureAuthLoaded(uid)
    local skins = auth_caches[uid]
    if skins then
        for _, name in ipairs(skins) do
            if name == skinname then
                return true
            end
        end
    end
    return false
end

-------------------------------------------------------------------------------
-- 主机：检查指定玩家是否拥有皮肤（主机判定使用服务器同步数据）
-------------------------------------------------------------------------------
TbatSkinCheckClientFn = function(_, userid, skinname)
    EnsureWorldSkinData()
    local info = TheWorld.tbat_skin_data and TheWorld.tbat_skin_data[userid]
    if not info or type(info.skins) ~= "table" then
        return false
    end

    for _, name in ipairs(info.skins) do
        if name == skinname then
            return true
        end
    end
    return false
end

-------------------------------------------------------------------------------
-- world 保存与加载钩子
-------------------------------------------------------------------------------
AddPrefabPostInit("world", function(inst)
    if not inst.ismastersim then
        return inst
    end

    local oldOnSave = inst.OnSave
    inst.OnSave = function(_inst, data)
        EnsureWorldSkinData()
        data.tbat_skin_data = TheWorld.tbat_skin_data
        if oldOnSave ~= nil then
            oldOnSave(inst, data)
        end
    end

    local oldOnLoad = inst.OnLoad
    inst.OnLoad = function(_inst, data)
        EnsureWorldSkinData()
        if data and data.tbat_skin_data then
            TheWorld.tbat_skin_data = data.tbat_skin_data
        end
        if oldOnLoad ~= nil then
            oldOnLoad(inst, data)
        end
    end
end)
