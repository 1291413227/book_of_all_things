local _G = GLOBAL
local containers = require("containers")
local params = {}

-- 兼容模组"Show Me (中文)"的容器列表
local showmeneed = {
    "tbat_spirit_pool",
    "tbat_pet_washer",
    "tbat_spirit_pool_hnct",
}

-- ================================
--[[注册容器:幻灵水池]]
-- ================================
params.tbat_spirit_pool =
{
    widget =
    {
        slotpos = {
            Vector3(-68, 43, 0),
            Vector3(7, 43, 0),
            Vector3(82, 43, 0),
            Vector3(-68, -32, 0),
            Vector3(7, -32, 0),
            Vector3(82, -32, 0),
            Vector3(-68, -107, 0),
            Vector3(7, -107, 0),
            Vector3(82, -107, 0),
        },
        slotbg =
        {
            { image = "pool_slot_fish.tex", atlas = "images/tbat_hud.xml" },
            { image = "pool_slot_fish.tex", atlas = "images/tbat_hud.xml" },
            { image = "pool_slot_fish.tex", atlas = "images/tbat_hud.xml" },
            { image = "pool_slot_fish.tex", atlas = "images/tbat_hud.xml" },
            { image = "pool_slot_bait.tex", atlas = "images/tbat_hud.xml" },
            { image = "pool_slot_fish.tex", atlas = "images/tbat_hud.xml" },
            { image = "pool_slot_fish.tex", atlas = "images/tbat_hud.xml" },
            { image = "pool_slot_fish.tex", atlas = "images/tbat_hud.xml" },
            { image = "pool_slot_fish.tex", atlas = "images/tbat_hud.xml" },
        },
        animbank = "ui_tbat_spirit_pool_3x3",
        animbuild = "ui_tbat_spirit_pool_3x3",
        pos = Vector3(0, 200, 0), -- 容器默认坐标
        side_align_tip = 160,
        buttoninfo =
        {
            atlas = "images/tbat_hud.xml",
            normal = "spirit_pool_close_button.tex",
            focus = "spirit_pool_close_button.tex",
            disabled = "spirit_pool_close_button.tex",
            position = Vector3(189, 179, 0),
        },
    },
    type = "chest", -- 容器类型,可以自定义,不同的容器类型可以同时打开
    usespecificslotsforitems = true,
}

function params.tbat_spirit_pool.itemtestfn(container, item, slot)
    return (slot ~= 5 and (item:HasTag("smalloceancreature") or item:HasTag("fish"))) or
        (slot == 5 and item:HasTag("tbat_reef_conch")) or
        (slot == nil and (item:HasTag("smalloceancreature") or item:HasTag("tbat_reef_conch") or item:HasTag("fish")))
end

function params.tbat_spirit_pool.widget.buttoninfo.fn(inst, doer)
    if inst.components.container ~= nil then
        BufferedAction(doer, inst, ACTIONS.RUMMAGE):Do()
    elseif inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
        SendModRPCToServer(MOD_RPC.BOOKOFALLTHINGS.Closecontainer, inst)
    end
end

-- ================================
--[[注册容器:幻灵水池-欢闹池塘]]
-- ================================
params.tbat_spirit_pool_hnct =
{
    widget =
    {
        slotpos = {
            Vector3(-72, 45, 0),
            Vector3(0, 45, 0),
            Vector3(72, 45, 0),
            Vector3(-72, -27, 0),
            Vector3(0, -27, 0),
            Vector3(72, -27, 0),
            Vector3(-72, -99, 0),
            Vector3(0, -99, 0),
            Vector3(72, -99, 0),
        },
        slotbg =
        {
            { image = "pool_skin1_slot_fish.tex", atlas = "images/tbat_hud.xml" },
            { image = "pool_skin1_slot_fish.tex", atlas = "images/tbat_hud.xml" },
            { image = "pool_skin1_slot_fish.tex", atlas = "images/tbat_hud.xml" },
            { image = "pool_skin1_slot_fish.tex", atlas = "images/tbat_hud.xml" },
            { image = "pool_skin1_slot_bait.tex", atlas = "images/tbat_hud.xml" },
            { image = "pool_skin1_slot_fish.tex", atlas = "images/tbat_hud.xml" },
            { image = "pool_skin1_slot_fish.tex", atlas = "images/tbat_hud.xml" },
            { image = "pool_skin1_slot_fish.tex", atlas = "images/tbat_hud.xml" },
            { image = "pool_skin1_slot_fish.tex", atlas = "images/tbat_hud.xml" },
        },
        animbank = "ui_tbat_spirit_pool_hnct_3x3",
        animbuild = "ui_tbat_spirit_pool_hnct_3x3",
        pos = Vector3(0, 200, 0), -- 容器默认坐标
        side_align_tip = 160,
        buttoninfo =
        {
            atlas = "images/tbat_hud.xml",
            normal = "spirit_pool_skin1_close_button.tex",
            focus = "spirit_pool_skin1_close_button.tex",
            disabled = "spirit_pool_skin1_close_button.tex",
            position = Vector3(189, 179, 0),
        },
    },
    type = "chest", -- 容器类型,可以自定义,不同的容器类型可以同时打开
    usespecificslotsforitems = true,
}

function params.tbat_spirit_pool_hnct.itemtestfn(container, item, slot)
    return (slot ~= 5 and (item:HasTag("smalloceancreature") or item:HasTag("fish"))) or
        (slot == 5 and item:HasTag("tbat_reef_conch")) or
        (slot == nil and (item:HasTag("smalloceancreature") or item:HasTag("tbat_reef_conch") or item:HasTag("fish")))
end

function params.tbat_spirit_pool_hnct.widget.buttoninfo.fn(inst, doer)
    if inst.components.container ~= nil then
        BufferedAction(doer, inst, ACTIONS.RUMMAGE):Do()
    elseif inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
        SendModRPCToServer(MOD_RPC.BOOKOFALLTHINGS.Closecontainer, inst)
    end
end

-- ================================
--[[注册容器:玫瑰双生鹅-地皮]]
-- ================================
local tbat_rose_twin_goose_table = {
    "tbat_rose_twin_goose_container",
    "tbat_rose_twin_goose_wall_container",
    "tbat_rose_twin_goose_fence_container",
    "tbat_rose_twin_goose_plantable_container",
    "tbat_rose_twin_goose_miscellaneous_container",
    "tbat_rose_twin_goose_material_container",
    "tbat_rose_twin_goose_decorate_container",
}

local function GetTwinGooseLevel()
    if TheWorld ~= nil and TheWorld.GetTBATTwinGooseLevel ~= nil then
        return TheWorld:GetTBATTwinGooseLevel()
    end
    return 0
end

local function validfn(container, doer, button, num)
    local prefab_name = tbat_rose_twin_goose_table[num]
    if prefab_name == container.prefab then
        if button then
            button:SetTextures(
                "images/tbat_hud.xml",
                "rose_twin_goose_button2.tex",
                "rose_twin_goose_button2.tex",
                "rose_twin_goose_button2.tex",
                nil,
                nil,
                { 0.9, 0.9 },
                { 0, 0 }
            )
        end
        return false
    else
        local level = GetTwinGooseLevel()
        if (prefab_name == "tbat_rose_twin_goose_material_container" or prefab_name == "tbat_rose_twin_goose_decorate_container")
            and level < 2 then
            if button and button.floating_image then
                button.floating_image:SetTexture("images/tbat_hud.xml", "lock.tex")
            end
            return false
        end
        return true
    end
end

params.tbat_rose_twin_goose_container =
{
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_tbat_rose_twin_goose_12x5",
        animbuild = "ui_tbat_rose_twin_goose_12x5",
        pos = Vector3(0, 50, 0),
        side_align_tip = 160,
        buttoninfo =
        {
            atlas = "images/tbat_hud.xml",
            normal = "rose_twin_goose_close_button.tex",
            focus = "rose_twin_goose_close_button.tex",
            disabled = "rose_twin_goose_close_button.tex",
            position = Vector3(550, 190, 0),
        },
        tbat_buttons = {
            {
                atlas = "images/tbat_hud.xml",
                normal = "rose_twin_goose_button1.tex",
                focus = "rose_twin_goose_button1.tex",
                disabled = "rose_twin_goose_button1.tex",
                scale = { 0.9, 0.9 },
                position = Vector3(-351.8, 188, 0),
                floating_image = {
                    atlas = "images/tbat_hud.xml",
                    image = "ground.tex",
                },
                validfn = function(container, doer, button)
                    return validfn(container, doer, button, 1)
                end,
                fn = function(container, doer)
                    SendModRPCToServer(MOD_RPC.BOOKOFALLTHINGS.Changecontainer, container, "tbat_rose_twin_goose")
                end,
            },
            {
                atlas = "images/tbat_hud.xml",
                normal = "rose_twin_goose_button1.tex",
                focus = "rose_twin_goose_button1.tex",
                disabled = "rose_twin_goose_button1.tex",
                scale = { 0.9, 0.9 },
                position = Vector3(-226.7, 188, 0),
                floating_image = {
                    atlas = "images/tbat_hud.xml",
                    image = "wall.tex",
                },
                validfn = function(container, doer, button)
                    return validfn(container, doer, button, 2)
                end,
                fn = function(container, doer)
                    SendModRPCToServer(MOD_RPC.BOOKOFALLTHINGS.Changecontainer, container, "tbat_rose_twin_goose_wall")
                end,
            },
            {
                atlas = "images/tbat_hud.xml",
                normal = "rose_twin_goose_button1.tex",
                focus = "rose_twin_goose_button1.tex",
                disabled = "rose_twin_goose_button1.tex",
                scale = { 0.9, 0.9 },
                position = Vector3(-101.6, 188, 0),
                floating_image = {
                    atlas = "images/tbat_hud.xml",
                    image = "fence.tex",
                },
                validfn = function(container, doer, button)
                    return validfn(container, doer, button, 3)
                end,
                fn = function(container, doer)
                    SendModRPCToServer(MOD_RPC.BOOKOFALLTHINGS.Changecontainer, container, "tbat_rose_twin_goose_fence")
                end,
            },
            {
                atlas = "images/tbat_hud.xml",
                normal = "rose_twin_goose_button1.tex",
                focus = "rose_twin_goose_button1.tex",
                disabled = "rose_twin_goose_button1.tex",
                scale = { 0.9, 0.9 },
                position = Vector3(23.5, 188, 0),
                floating_image = {
                    atlas = "images/tbat_hud.xml",
                    image = "plantable.tex",
                },
                validfn = function(container, doer, button)
                    return validfn(container, doer, button, 4)
                end,
                fn = function(container, doer)
                    SendModRPCToServer(MOD_RPC.BOOKOFALLTHINGS.Changecontainer, container, "tbat_rose_twin_goose_plantable")
                end,
            },
            {
                atlas = "images/tbat_hud.xml",
                normal = "rose_twin_goose_button1.tex",
                focus = "rose_twin_goose_button1.tex",
                disabled = "rose_twin_goose_button1.tex",
                scale = { 0.9, 0.9 },
                position = Vector3(148.6, 188, 0),
                floating_image = {
                    atlas = "images/tbat_hud.xml",
                    image = "miscellaneous.tex",
                },
                validfn = function(container, doer, button)
                    return validfn(container, doer, button, 5)
                end,
                fn = function(container, doer)
                    SendModRPCToServer(MOD_RPC.BOOKOFALLTHINGS.Changecontainer, container, "tbat_rose_twin_goose_miscellaneous")
                end,
            },
            {
                atlas = "images/tbat_hud.xml",
                normal = "rose_twin_goose_button1.tex",
                focus = "rose_twin_goose_button1.tex",
                disabled = "rose_twin_goose_button1.tex",
                scale = { 0.9, 0.9 },
                position = Vector3(273.7, 188, 0),
                floating_image = {
                    atlas = "images/tbat_hud.xml",
                    image = "material.tex",
                },
                validfn = function(container, doer, button)
                    return validfn(container, doer, button, 6)
                end,
                fn = function(container, doer)
                    SendModRPCToServer(MOD_RPC.BOOKOFALLTHINGS.Changecontainer, container, "tbat_rose_twin_goose_material")
                end,
            },
            {
                atlas = "images/tbat_hud.xml",
                normal = "rose_twin_goose_button1.tex",
                focus = "rose_twin_goose_button1.tex",
                disabled = "rose_twin_goose_button1.tex",
                scale = { 0.9, 0.9 },
                position = Vector3(398.8, 188, 0),
                floating_image = {
                    atlas = "images/tbat_hud.xml",
                    image = "decorate.tex",
                },
                validfn = function(container, doer, button)
                    return validfn(container, doer, button, 7)
                end,
                fn = function(container, doer)
                    SendModRPCToServer(MOD_RPC.BOOKOFALLTHINGS.Changecontainer, container, "tbat_rose_twin_goose_decorate")
                end,
            },
        },
    },
    type = "chest",
}

local rose_twin_goose_bg = { image = "rose_twin_goose_slot.tex", atlas = "images/tbat_hud.xml" }

for y = 0, 4 do
    table.insert(params.tbat_rose_twin_goose_container.widget.slotpos, Vector3(-402 + 0 * 70, -70 * y + 106, 0))
    table.insert(params.tbat_rose_twin_goose_container.widget.slotpos, Vector3(-402 + 1 * 70, -70 * y + 106, 0))
    table.insert(params.tbat_rose_twin_goose_container.widget.slotpos, Vector3(-402 + 2 * 70, -70 * y + 106, 0))
    table.insert(params.tbat_rose_twin_goose_container.widget.slotpos, Vector3(-402 + 3 * 70, -70 * y + 106, 0))
end
for y = 0, 4 do
    table.insert(params.tbat_rose_twin_goose_container.widget.slotpos, Vector3(-82 + 0 * 70, -70 * y + 106, 0))
    table.insert(params.tbat_rose_twin_goose_container.widget.slotpos, Vector3(-82 + 1 * 70, -70 * y + 106, 0))
    table.insert(params.tbat_rose_twin_goose_container.widget.slotpos, Vector3(-82 + 2 * 70, -70 * y + 106, 0))
    table.insert(params.tbat_rose_twin_goose_container.widget.slotpos, Vector3(-82 + 3 * 70, -70 * y + 106, 0))
end
for y = 0, 4 do
    table.insert(params.tbat_rose_twin_goose_container.widget.slotpos, Vector3(238 + 0 * 70, -70 * y + 106, 0))
    table.insert(params.tbat_rose_twin_goose_container.widget.slotpos, Vector3(238 + 1 * 70, -70 * y + 106, 0))
    table.insert(params.tbat_rose_twin_goose_container.widget.slotpos, Vector3(238 + 2 * 70, -70 * y + 106, 0))
    table.insert(params.tbat_rose_twin_goose_container.widget.slotpos, Vector3(238 + 3 * 70, -70 * y + 106, 0))
end
for i = 1, 60 do
    table.insert(params.tbat_rose_twin_goose_container.widget.slotbg, rose_twin_goose_bg)
end
function params.tbat_rose_twin_goose_container.itemtestfn(container, item, slot)
    return item:HasTag("groundtile")
end

function params.tbat_rose_twin_goose_container.widget.buttoninfo.fn(inst, doer)
    if inst.components.container ~= nil then
        BufferedAction(doer, inst, ACTIONS.RUMMAGE):Do()
    elseif inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
        SendModRPCToServer(MOD_RPC.BOOKOFALLTHINGS.Closecontainer, inst)
    end
end

-- ================================
--[[注册容器:玫瑰双生鹅-墙体]]
-- ================================
params.tbat_rose_twin_goose_wall_container = deepcopy(params.tbat_rose_twin_goose_container)

function params.tbat_rose_twin_goose_wall_container.itemtestfn(container, item, slot)
    return item:HasTag("wallbuilder")
end

-- ================================
--[[注册容器:玫瑰双生鹅-栅栏]]
-- ================================
params.tbat_rose_twin_goose_fence_container = deepcopy(params.tbat_rose_twin_goose_container)

function params.tbat_rose_twin_goose_fence_container.itemtestfn(container, item, slot)
    return item:HasTag("fencebuilder")
end

-- ================================
--[[注册容器:玫瑰双生鹅-移植]]
-- ================================
params.tbat_rose_twin_goose_plantable_container = deepcopy(params.tbat_rose_twin_goose_container)

function params.tbat_rose_twin_goose_plantable_container.itemtestfn(container, item, slot)
    return item:HasTag("deployedplant") or item:HasTag("deployable")
end

-- ================================
--[[注册容器:玫瑰双生鹅-杂项]]
-- ================================
params.tbat_rose_twin_goose_miscellaneous_container = deepcopy(params.tbat_rose_twin_goose_container)

function params.tbat_rose_twin_goose_miscellaneous_container.itemtestfn(container, item, slot)
    return not item:HasTag("irreplaceable")
end

-- ================================
--[[注册容器:玫瑰双生鹅-材料]]
-- ================================
params.tbat_rose_twin_goose_material_container = deepcopy(params.tbat_rose_twin_goose_container)

function params.tbat_rose_twin_goose_material_container.itemtestfn(container, item, slot)
    return not item:HasTag("irreplaceable")
end

-- ================================
--[[注册容器:玫瑰双生鹅-装饰]]
-- ================================
params.tbat_rose_twin_goose_decorate_container = deepcopy(params.tbat_rose_twin_goose_container)

function params.tbat_rose_twin_goose_decorate_container.itemtestfn(container, item, slot)
    return not item:HasTag("irreplaceable")
end

-- ================================
--[[注册容器:萌宠洗衣机]]
-- ================================
params.tbat_pet_washer = {
    widget =
    {
        slotpos = {},
        slotbg = {},
        animbank = "ui_tbat_pet_washer_6x3",
        animbuild = "ui_tbat_pet_washer_6x3",
        pos = Vector3(0, 180, 0),
        side_align_tip = 160,
        buttoninfo =
        {
            atlas = "images/tbat_hud.xml",
            normal = "pet_washer_close_button.tex",
            focus = "pet_washer_close_button.tex",
            disabled = "pet_washer_close_button.tex",
            position = Vector3(178, 135, 0),
        },
        tbat_buttons = {
            {
                atlas = "images/tbat_hud.xml",
                normal = "pet_washer_button1.tex",
                focus = "pet_washer_button1.tex",
                disabled = "pet_washer_button1.tex",
                position = Vector3(-270, 35, 0),
                fn = function(container, doer)
                    SendModRPCToServer(MOD_RPC.BOOKOFALLTHINGS.UsePetWasher, container, "add")
                end,
            },
            {
                atlas = "images/tbat_hud.xml",
                normal = "pet_washer_button2.tex",
                focus = "pet_washer_button2.tex",
                disabled = "pet_washer_button2.tex",
                position = Vector3(282, 35, 0),
                fn = function(container, doer)
                    SendModRPCToServer(MOD_RPC.BOOKOFALLTHINGS.UsePetWasher, container, "reduce")
                end,
            },
        },
    },
    type = "chest",
    usespecificslotsforitems = true,
}

for y = 0, 2 do
    table.insert(params.tbat_pet_washer.widget.slotpos, Vector3(-175 + 0 * 72, -72 * y + 33, 0))
    table.insert(params.tbat_pet_washer.widget.slotpos, Vector3(-175 + 1 * 72, -72 * y + 33, 0))
    table.insert(params.tbat_pet_washer.widget.slotpos, Vector3(-175 + 2 * 72, -72 * y + 33, 0))
    table.insert(params.tbat_pet_washer.widget.slotpos, Vector3(-175 + 3 * 72, -72 * y + 33, 0))
    table.insert(params.tbat_pet_washer.widget.slotpos, Vector3(-175 + 4 * 72, -72 * y + 33, 0))
    table.insert(params.tbat_pet_washer.widget.slotpos, Vector3(-175 + 5 * 72, -72 * y + 33, 0))
end

local pet_washer_bg = { image = "pet_washer_slot.tex", atlas = "images/tbat_hud.xml" }
local pet_washer_bg_props = { image = "pet_washer_slot_props.tex", atlas = "images/tbat_hud.xml" }

for i = 1, 18 do
    table.insert(params.tbat_pet_washer.widget.slotbg, pet_washer_bg)
end

table.insert(params.tbat_pet_washer.widget.slotpos, Vector3(-135, 133, 0))
table.insert(params.tbat_pet_washer.widget.slotbg, pet_washer_bg_props)

function params.tbat_pet_washer.itemtestfn(container, item, slot)
    return (slot ~= 19 and item:HasTag("tbat_pet_washer_able")) or
        (slot == 19 and item.prefab == "tbat_material_lavender_laundry_detergent") or
        (slot == nil and (item.prefab == "tbat_material_lavender_laundry_detergent" or item:HasTag("tbat_pet_washer_able")))
end

function params.tbat_pet_washer.widget.buttoninfo.fn(inst, doer)
    if inst.components.container ~= nil then
        BufferedAction(doer, inst, ACTIONS.RUMMAGE):Do()
    elseif inst.replica.container ~= nil and not inst.replica.container:IsBusy() then
        SendModRPCToServer(MOD_RPC.BOOKOFALLTHINGS.Closecontainer, inst)
    end
end

-- ================================
--[[修改容器注册函数]]
-- ================================
for k, v in pairs(params) do
    containers.params[k] = v

    -- 更新容器格子数量的最大值
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end

-- ================================
--[[mod兼容：Show Me (中文)]]
-- ================================
-- showme优先级如果比本mod高，那么这部分代码会生效
for k, mod in pairs(ModManager.mods) do
    if mod and _G.rawget(mod, "SHOWME_STRINGS") then -- showme特有的全局变量
        if
            mod.postinitfns and mod.postinitfns.PrefabPostInit and
            mod.postinitfns.PrefabPostInit.treasurechest
        then
            for _, v in ipairs(showmeneed) do
                mod.postinitfns.PrefabPostInit[v] = mod.postinitfns.PrefabPostInit.treasurechest
            end
        end
        break
    end
end

-- showme优先级如果比本mod低，那么这部分代码会生效
TUNING.MONITOR_CHESTS = TUNING.MONITOR_CHESTS or {}
for _, v in ipairs(showmeneed) do
    TUNING.MONITOR_CHESTS[v] = true
end

-- 释放内存
params = nil
showmeneed = nil
