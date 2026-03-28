-- 代码作者：ti_Tout

local _G = GLOBAL

--------------------------------------------------------------------------
--[[ 修改默认的科技树生成方式 ]]
--------------------------------------------------------------------------

local TechTree = require("techtree")

table.insert(TechTree.AVAILABLE_TECH, "TBAT_TWIN_GOOSE_TECH") -- 其实就是加个自己的科技树名称

local Create_old = TechTree.Create
TechTree.Create = function(t, ...)
    local newt = Create_old(t, ...)
    newt["TBAT_TWIN_GOOSE_TECH"] = newt["TBAT_TWIN_GOOSE_TECH"] or 0
    return newt
end

--------------------------------------------------------------------------
--[[ 新制作栏 ]]
--------------------------------------------------------------------------

-- 双生栏
AddRecipeFilter({
    name = "TBAT_TWIN_GOOSE",
    atlas = "images/tbat_crafting_menu_icons.xml",
    image = "station_tbat_rose_twin_goose.tex",
    custom_pos = true
})

--------------------------------------------------------------------------
--[[ 制作等级中加入自己的部分 ]]
--------------------------------------------------------------------------

_G.TECH.NONE.TBAT_TWIN_GOOSE_TECH = 0
_G.TECH.TBAT_TWIN_GOOSE_TECH_ONE = { TBAT_TWIN_GOOSE_TECH = 1 }

--------------------------------------------------------------------------
--[[ 解锁等级中加入自己的部分 ]]
--------------------------------------------------------------------------

for k, v in pairs(TUNING.PROTOTYPER_TREES) do
    v.TBAT_TWIN_GOOSE_TECH = 0
end

-- TBAT_TWIN_GOOSE_TECH_ONE 可以改成任意的名字,这里和 TECH.TBAT_TWIN_GOOSE_TECH_ONE 名字相同只是懒得改了
TUNING.PROTOTYPER_TREES.TBAT_TWIN_GOOSE_TECH_ONE = TechTree.Create({
    TURFCRAFTING = 2,
    MASHTURFCRAFTING = 2,
    CARPENTRY = 3,
    -- SCIENCE = 2,
    -- -- 双生鹅科技
    TBAT_TWIN_GOOSE_TECH = 1,
    -- 活动科技
    PERDOFFERING = 3,
    WARGOFFERING = 3,
    PIGOFFERING = 3,
    CARRATOFFERING = 3,
    BEEFOFFERING = 3,
    CATCOONOFFERING = 3,
    RABBITOFFERING = 3,
    DRAGONOFFERING = 3,
    WORMOFFERING = 3,
    KNIGHTOFFERING = 3,
    -- MADSCIENCE = 1,
    CARNIVAL_PRIZESHOP = 1,
    CARNIVAL_HOSTSHOP = 3,
})

--------------------------------------------------------------------------
--[[ 修改全部制作配方，对缺失的值进行补充 ]]
--------------------------------------------------------------------------

for i, v in pairs(AllRecipes) do
    if v.level.TBAT_TWIN_GOOSE_TECH == nil then
        v.level.TBAT_TWIN_GOOSE_TECH = 0
    end
end
