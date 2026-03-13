-- 官方的皮肤:skinprefabs.lua
-- https://dontstarve.fandom.com/wiki/Belongings
--[[
    skinsutils.lua查看品质分类,以下是财务皮肤常用的品质分类:
    Event:活动:活动期间才可以使用的皮肤:金色
    ProofOfPurchase:购买凭证:购买周边赠送的皮肤:深绿色
    Timeless:永恒:过去活动登录赠送的皮肤:较深绿色
    Loyal:忠诚:科雷点数商店换取的皮肤:浅绿色
    HeirloomElegant:祖传优雅:曾经不可编织的红皮如今有可以编织的,但是为了和可编织的区分开单独另算一种皮肤,拆掉获取1350线轴:深红色
    HeirloomDistinguished:祖传杰出:曾经不可编织的粉皮如今有可以编织的,但是为了和可编织的区分开单独另算一种皮肤,拆掉获取450线轴:深红色
    Elegant:优雅:就是我们常说的红色皮肤,包括编织的和不可编织的,拆掉获取450线轴:红色
    Distinguished:杰出:粉色皮肤,包括编织的和不可编织的,拆掉获取150线轴:粉色
    Spiffy:炫酷:紫色皮肤,包括编织的和不可编织的,拆掉获取50线轴:紫色
    Classy:上等:蓝色皮肤,包括编织的和不可编织的,拆掉获取15线轴:蓝色
    Complimentary:免费:普通皮肤,不变色,所有账号自动获取,原版仅唱片CD
]]

-- 小径石板·1
BOOKOFALLTHINGS.MakeItemSkinDefaultImage("tbat_pathway_slab", "images/tbat_inventoryimages.xml", "tbat_pathway_slab")
BOOKOFALLTHINGS.MakeItemSkin(
    "tbat_pathway_slab",                                          -- 默认皮肤代码
    "tbat_pathway_slab_skin1",                                    -- 皮肤代码
    {
        name = STRINGS.TBAT_STRINGS.TBAT_PATHWAY_SLAB_SKIN1_NAME, -- 皮肤名字,写在中英文lua文件里
        des = "None",                                             -- 皮肤描述
        rarity = "Complimentary",                                 -- 皮肤品质:参见上方品质分类
        atlas = "images/tbat_inventoryimages.xml",
        image = "tbat_pathway_slab_skin1",
        build = "tbat_pathway_slab_skin1",                     -- 皮肤动画材质包名
        bank = "tbat_pathway_slab_skin1",                      -- 皮肤动画集合名
        basebuild = "tbat_pathway_slab",                       -- 原皮动画材质包名
        basebank = "tbat_pathway_slab",                        -- 原皮动画集合名
        assets = {
            Asset("ANIM", "anim/tbat_pathway_slab_skin1.zip"), -- 皮肤动画文件路径
        },
    }
)
BOOKOFALLTHINGS.MakeItemSkinDefaultImage("tbat_pathway_slab_item", "images/tbat_inventoryimages.xml", "tbat_pathway_slab_item")
BOOKOFALLTHINGS.MakeItemSkin(
    "tbat_pathway_slab_item",
    "tbat_pathway_slab_item_skin1",
    {
        name = STRINGS.TBAT_STRINGS.TBAT_PATHWAY_SLAB_SKIN1_NAME,
        des = "None",
        rarity = "Complimentary",
        atlas = "images/tbat_inventoryimages.xml",
        image = "tbat_pathway_slab_item_skin1",
        build = "tbat_pathway_slab_skin1",
        bank = "tbat_pathway_slab_skin1",
        basebuild = "tbat_pathway_slab",
        basebank = "tbat_pathway_slab",
        assets = {
            Asset("ANIM", "anim/tbat_pathway_slab_skin1.zip"),
        },
        init_fn = function(inst, skinname)
            inst.overridedeployplacername = "tbat_pathway_slab_item_skin1_placer"
            inst._placer:set(1)
        end,
        clear_fn = function(inst, skinname)
            inst.overridedeployplacername = "tbat_pathway_slab_item_placer"
            inst._placer:set(0)
        end,
    }
)

-- 小径石板·2
BOOKOFALLTHINGS.MakeItemSkinDefaultImage("tbat_pathway_slab", "images/tbat_inventoryimages.xml", "tbat_pathway_slab")
BOOKOFALLTHINGS.MakeItemSkin(
    "tbat_pathway_slab",
    "tbat_pathway_slab_skin2",
    {
        name = STRINGS.TBAT_STRINGS.TBAT_PATHWAY_SLAB_SKIN2_NAME,
        des = "None",
        rarity = "Complimentary",
        atlas = "images/tbat_inventoryimages.xml",
        image = "tbat_pathway_slab_skin2",
        build = "tbat_pathway_slab_skin2",
        bank = "tbat_pathway_slab_skin2",
        basebuild = "tbat_pathway_slab",
        basebank = "tbat_pathway_slab",
        assets = {
            Asset("ANIM", "anim/tbat_pathway_slab_skin2.zip"),
        },
    }
)
BOOKOFALLTHINGS.MakeItemSkinDefaultImage("tbat_pathway_slab_item", "images/tbat_inventoryimages.xml", "tbat_pathway_slab_item")
BOOKOFALLTHINGS.MakeItemSkin(
    "tbat_pathway_slab_item",
    "tbat_pathway_slab_item_skin2",
    {
        name = STRINGS.TBAT_STRINGS.TBAT_PATHWAY_SLAB_SKIN2_NAME,
        des = "None",
        rarity = "Complimentary",
        atlas = "images/tbat_inventoryimages.xml",
        image = "tbat_pathway_slab_item_skin2",
        build = "tbat_pathway_slab_skin2",
        bank = "tbat_pathway_slab_skin2",
        basebuild = "tbat_pathway_slab",
        basebank = "tbat_pathway_slab",
        assets = {
            Asset("ANIM", "anim/tbat_pathway_slab_skin2.zip"),
        },
        init_fn = function(inst, skinname)
            inst.overridedeployplacername = "tbat_pathway_slab_item_skin2_placer"
            inst._placer:set(2)
        end,
        clear_fn = function(inst, skinname)
            inst.overridedeployplacername = "tbat_pathway_slab_item_placer"
            inst._placer:set(0)
        end,
    }
)

-- 小径石板·3
BOOKOFALLTHINGS.MakeItemSkinDefaultImage("tbat_pathway_slab", "images/tbat_inventoryimages.xml", "tbat_pathway_slab")
BOOKOFALLTHINGS.MakeItemSkin(
    "tbat_pathway_slab",
    "tbat_pathway_slab_skin3",
    {
        name = STRINGS.TBAT_STRINGS.TBAT_PATHWAY_SLAB_SKIN3_NAME,
        des = "None",
        rarity = "Complimentary",
        atlas = "images/tbat_inventoryimages.xml",
        image = "tbat_pathway_slab_skin3",
        build = "tbat_pathway_slab_skin3",
        bank = "tbat_pathway_slab_skin3",
        basebuild = "tbat_pathway_slab",
        basebank = "tbat_pathway_slab",
        assets = {
            Asset("ANIM", "anim/tbat_pathway_slab_skin3.zip"),
        },
    }
)
BOOKOFALLTHINGS.MakeItemSkinDefaultImage("tbat_pathway_slab_item", "images/tbat_inventoryimages.xml", "tbat_pathway_slab_item")
BOOKOFALLTHINGS.MakeItemSkin(
    "tbat_pathway_slab_item",
    "tbat_pathway_slab_item_skin3",
    {
        name = STRINGS.TBAT_STRINGS.TBAT_PATHWAY_SLAB_SKIN3_NAME,
        des = "None",
        rarity = "Complimentary",
        atlas = "images/tbat_inventoryimages.xml",
        image = "tbat_pathway_slab_item_skin3",
        build = "tbat_pathway_slab_skin3",
        bank = "tbat_pathway_slab_skin3",
        basebuild = "tbat_pathway_slab",
        basebank = "tbat_pathway_slab",
        assets = {
            Asset("ANIM", "anim/tbat_pathway_slab_skin3.zip"),
        },
        init_fn = function(inst, skinname)
            inst.overridedeployplacername = "tbat_pathway_slab_item_skin3_placer"
            inst._placer:set(3)
        end,
        clear_fn = function(inst, skinname)
            inst.overridedeployplacername = "tbat_pathway_slab_item_placer"
            inst._placer:set(0)
        end,
    }
)

-- 小浣熊木牌-5款免费皮肤
local sign_skins = {
    "town",
    "street",
    "kitchen",
    "home",
    "restaurant",
}

for i, v in ipairs(sign_skins) do
    BOOKOFALLTHINGS.MakeItemSkinDefaultImage("tbat_raccoon_sign", "images/tbat_inventoryimages.xml", "tbat_raccoon_sign")
    BOOKOFALLTHINGS.MakeItemSkin(
        "tbat_raccoon_sign",
        "tbat_raccoon_sign_" .. v,
        {
            name = STRINGS.TBAT_STRINGS["TBAT_RACCOON_SIGN_" .. string.upper(v) .. "_NAME"],
            des = "None",
            rarity = "Complimentary",
            atlas = "images/tbat_inventoryimages.xml",
            image = "tbat_raccoon_sign_" .. v,
            build = "tbat_raccoon_sign",
            bank = "tbat_raccoon_sign",
            basebuild = "tbat_raccoon_sign",
            basebank = "tbat_raccoon_sign",
            init_fn = function(inst, skinname)
                inst.AnimState:OverrideSymbol("content", "tbat_raccoon_sign_content", v)
            end,
            clear_fn = function(inst, skinname)
                inst.AnimState:OverrideSymbol("content", "tbat_raccoon_sign_content", "default")
            end,
        }
    )
end

-- 晓光玫瑰藤蔓-7款免费皮肤
local vine_skins = {
    "osmanthus",
    "spike",
    "plumsnow",
    "forestsong",
    "pearl",
    "foxmaple",
    "autumnmaple",
}

for i, v in ipairs(vine_skins) do
    BOOKOFALLTHINGS.MakeItemSkinDefaultImage("tbat_vine_rose", "images/tbat_inventoryimages.xml", "tbat_vine_rose")
    BOOKOFALLTHINGS.MakeItemSkin(
        "tbat_vine_rose",
        "tbat_vine_" .. v,
        {
            name = STRINGS.TBAT_STRINGS["TBAT_VINE_" .. string.upper(v) .. "_NAME"],
            des = "None",
            rarity = "Complimentary",
            atlas = "images/tbat_inventoryimages.xml",
            image = "tbat_vine_" .. v,
            build = "tbat_vine_" .. v,
            bank = "tbat_vine_" .. v,
            basebuild = "tbat_vine_rose",
            basebank = "tbat_vine_rose",
            assets = {
                Asset("ANIM", "anim/tbat_vine_" .. v .. ".zip"),
            },
        }
    )
end

-- 幻海珊瑚-幻海浮藻
BOOKOFALLTHINGS.MakeItemSkinDefaultImage("tbat_dreamsea_coral", "images/tbat_inventoryimages.xml", "tbat_dreamsea_coral")
BOOKOFALLTHINGS.MakeItemSkin(
    "tbat_dreamsea_coral",
    "tbat_dreamsea_coral_skin1",
    {
        name = STRINGS.TBAT_STRINGS.TBAT_DREAMSEA_CORAL_SKIN1_NAME,
        des = "None",
        rarity = "Complimentary",
        atlas = "images/tbat_inventoryimages.xml",
        image = "tbat_dreamsea_coral_skin1",
        build = "tbat_dreamsea_coral_skin1",
        bank = "tbat_dreamsea_coral_skin1",
        basebuild = "tbat_dreamsea_coral",
        basebank = "tbat_dreamsea_coral",
        assets = {
            Asset("ANIM", "anim/tbat_dreamsea_coral_skin1.zip"),
        },
    }
)

-- 幻海珊瑚-幻海凝珠
BOOKOFALLTHINGS.MakeItemSkinDefaultImage("tbat_dreamsea_coral", "images/tbat_inventoryimages.xml", "tbat_dreamsea_coral")
BOOKOFALLTHINGS.MakeItemSkin(
    "tbat_dreamsea_coral",
    "tbat_dreamsea_coral_skin2",
    {
        name = STRINGS.TBAT_STRINGS.TBAT_DREAMSEA_CORAL_SKIN2_NAME,
        des = "None",
        rarity = "Complimentary",
        atlas = "images/tbat_inventoryimages.xml",
        image = "tbat_dreamsea_coral_skin2",
        build = "tbat_dreamsea_coral_skin2",
        bank = "tbat_dreamsea_coral_skin2",
        basebuild = "tbat_dreamsea_coral",
        basebank = "tbat_dreamsea_coral",
        assets = {
            Asset("ANIM", "anim/tbat_dreamsea_coral_skin2.zip"),
        },
    }
)