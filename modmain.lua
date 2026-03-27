-- 下行代码只代表查值时自动查global,增加global的变量或者修改global的变量时还是需要带"GLOBAL."
GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })
GLOBAL.BOOKOFALLTHINGS = env

-- ※标注的地方大概率在新增内容的时候需要添加对应的参数,请仔细核对※标注的部分

-- 获取mod配置,放到官方的全局变量tuning表中
TUNING.BOOKOFALLTHINGS = {}
TUNING.BOOKOFALLTHINGS.LANGUAGE = GetModConfigData("languages") -- 获取配置:语言

-- 设置语言
if TUNING.BOOKOFALLTHINGS.LANGUAGE == "Chinese" then
    modimport("scripts/languages/tbat_chinese.lua") -- ※中文
elseif TUNING.BOOKOFALLTHINGS.LANGUAGE == "English" then
    modimport("scripts/languages/tbat_english.lua") -- ※英文
else
    modimport("scripts/languages/tbat_chinese.lua")
end

-- ※万物皆是prefab
PrefabFiles = {
    "tbat_free_skins",                    -- 免费皮肤
    "tbat_permissions_skins",             -- 权限皮肤
    "tbat_adventurers_notes",             -- 冒险家笔记
    "tbat_spirit_pool",                   -- 幻灵水池
    "tbat_reef_conch",                    -- 礁石海螺
    "tbat_meadow_rocking_chair",          -- 绿野摇摇椅
    "tbat_pathway_slab",                  -- 小径石板
    "tbat_fence",                         -- 栅栏
    "tbat_dreamweaver_peachcloud_tree",   -- 织梦桃云树
    "tbat_moonlit_memory_crystal_spring", -- 月光记忆晶泉
    "tbat_vine_rose",                     -- 晓光玫瑰藤蔓
    "tbat_dreamsea_coral",                -- 幻海珊瑚
    "tbat_rose_twin_goose",               -- 玫瑰双生鹅
    "tbat_rose_goose_egg",                -- 玫瑰小鹅蛋
    "tbat_pet_washer",                    -- 萌宠洗衣机
}

Assets = {
    Asset("ATLAS", "images/tbat_inventoryimages.xml"), -- 物品栏贴图集
    Asset("IMAGE", "images/tbat_inventoryimages.tex"),
    Asset("ATLAS_BUILD", "images/tbat_inventoryimages.xml", 256),

    Asset("ATLAS", "images/tbat_crafting_menu_icons.xml"), -- 科技栏图标
    Asset("IMAGE", "images/tbat_crafting_menu_icons.tex"),

    Asset("ATLAS", "images/tbat_ui.xml"), -- UI图集
    Asset("IMAGE", "images/tbat_ui.tex"),

    Asset("ATLAS", "images/tbat_hud.xml"), -- HUD图集
    Asset("IMAGE", "images/tbat_hud.tex"),

    Asset("ATLAS", "minimap/tbat_minimap.xml"), -- 小地图贴图集
    Asset("IMAGE", "minimap/tbat_minimap.tex"),

    Asset("ANIM", "anim/ui_tbat_spirit_pool_3x3.zip"),      -- 幻灵水池UI动画
    Asset("ANIM", "anim/ui_tbat_spirit_pool_hnct_3x3.zip"), -- 幻灵水池皮肤UI动画
    Asset("ANIM", "anim/ui_tbat_rose_twin_goose_12x5.zip"), -- 玫瑰双生鹅UI动画
    Asset("ANIM", "anim/ui_tbat_pet_washer_6x3.zip"),       -- 萌宠洗衣机UI动画
}

-- 注册可复制组件
-- AddReplicableComponent("tbat_xxx")

-- 注册贴图集
modimport("scripts/tbat_tool.lua") -- 工具
TBAT_TOOL.Tool_RegisterInventoryItemAtlas("images/tbat_inventoryimages.xml")

-- 注册小地图图标
AddMinimapAtlas("minimap/tbat_minimap.xml")

-- 判断某些mod是否开启
modimport("scripts/tbat_linkmod.lua")

-- 全局函数
-- modimport("scripts/tbat_globalfn.lua")

-- 资源文件导入
modimport("scripts/tbat_tech.lua")                          -- 科技相关-要在制作配方前面
modimport("scripts/tbat_ui.lua")                            -- UI相关
modimport("scripts/tbat_sg.lua")                            -- 人物状态表相关
modimport("scripts/tbat_action.lua")                        -- 动作
modimport("scripts/tbat_hook.lua")                          -- 本mod钩子
if GLOBAL.BOOKOFEVERYTHING_SETS.ENABLEDMODS["old_tbat"] then
    modimport("scripts/tbat_recipe_old.lua")                -- 旧版新版一起开
else
    modimport("scripts/tbat_recipe.lua")                    -- 单开测试
end
modimport("scripts/tbat_containers.lua")                    -- 容器相关
modimport("scripts/tbat_pocketdimensioncontainer_defs.lua") -- 维度容器定义
modimport("scripts/tbat_rpc.lua")                           -- 本模组主客机通信
modimport("scripts/tbat_cooking.lua")                       -- 烹饪相关
modimport("scripts/tbat_skinapi.lua")                       -- 风铃的皮肤API
modimport("scripts/tbat_skin_ownership.lua")                -- 本地CDK/权限皮肤解锁
modimport("scripts/tbat_tiledefs.lua")                      -- 本mod地皮
modimport("scripts/tbat_klei_fix.lua")                      -- 给科雷修bug

-- require("tbat_debugcommands")        -- 调试用指令
