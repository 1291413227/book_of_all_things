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
    "tbat_adventurers_notes", -- 冒险家笔记
}

Assets = {
    Asset("ATLAS", "images/tbat_inventoryimages.xml"), -- 物品栏贴图集
    Asset("IMAGE", "images/tbat_inventoryimages.tex"),
    Asset("ATLAS_BUILD", "images/tbat_inventoryimages.xml", 256),

    Asset("ATLAS", "images/tbat_ui.xml"), -- UI图标
    Asset("IMAGE", "images/tbat_ui.tex"),

    -- Asset("ATLAS", "minimap/tbat_minimap.xml"), -- 小地图贴图集
    -- Asset("IMAGE", "minimap/tbat_minimap.tex"),
}

-- 注册可复制组件
-- AddReplicableComponent("tbat_xxx")

-- 注册贴图集
modimport("scripts/tbat_tool.lua") -- 工具
TBAT_TOOL.Tool_RegisterInventoryItemAtlas("images/tbat_inventoryimages.xml")

-- 注册小地图图标
-- AddMinimapAtlas("minimap/tbat_minimap.xml")

-- 判断某些mod是否开启
modimport("scripts/tbat_linkmod.lua")

-- 全局函数
-- modimport("scripts/tbat_globalfn.lua")

-- 资源文件导入
modimport("scripts/tbat_ui.lua")     -- UI相关
modimport("scripts/tbat_sg.lua")     -- 人物状态表相关
modimport("scripts/tbat_action.lua") -- 动作
modimport("scripts/tbat_hook.lua")   -- 本mod钩子

-- require("tbat_debugcommands")        -- 调试用指令
