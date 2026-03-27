-- 晓光玫瑰藤蔓-2款权限皮肤
local vine_skins = {
    "current",
    "dreamcatcher",
}

for i, v in ipairs(vine_skins) do
    BOOKOFALLTHINGS.MakeItemSkinDefaultImage("tbat_vine_rose", "images/tbat_inventoryimages.xml", "tbat_vine_rose")
    BOOKOFALLTHINGS.MakeItemSkin(
        "tbat_vine_rose",
        "tbat_vine_" .. v,
        {
            name = STRINGS.TBAT_STRINGS["TBAT_VINE_" .. string.upper(v) .. "_NAME"],
            des = "None",
            rarity = "tbat_purple",
            raritycorlor = { 238 / 255, 130 / 255, 238 / 255, 1 }, -- purple
            atlas = "images/tbat_inventoryimages.xml",
            image = "tbat_vine_" .. v,
            build = "tbat_vine_" .. v,
            bank = "tbat_vine_" .. v,
            basebuild = "tbat_vine_rose",
            basebank = "tbat_vine_rose",
            assets = {
                Asset("ANIM", "anim/tbat_vine_" .. v .. ".zip"),
            },
            checkfn = BOOKOFALLTHINGS.TbatSkinCheckFn,
            checkclientfn = BOOKOFALLTHINGS.TbatSkinCheckClientFn,
        }
    )
end

-- 幻海珊瑚-幻海流萤
BOOKOFALLTHINGS.MakeItemSkinDefaultImage("tbat_dreamsea_coral", "images/tbat_inventoryimages.xml", "tbat_dreamsea_coral_hhly")
BOOKOFALLTHINGS.MakeItemSkin(
    "tbat_dreamsea_coral",
    "tbat_dreamsea_coral_hhly",
    {
        name = STRINGS.TBAT_STRINGS.TBAT_DREAMSEA_CORAL_HHLY_NAME,
        des = "None",
        rarity = "tbat_purple",
        raritycorlor = { 238 / 255, 130 / 255, 238 / 255, 1 }, -- purple
        atlas = "images/tbat_inventoryimages.xml",
        image = "tbat_dreamsea_coral_hhly",
        build = "tbat_dreamsea_coral_hhly",
        bank = "tbat_dreamsea_coral_hhly",
        basebuild = "tbat_dreamsea_coral",
        basebank = "tbat_dreamsea_coral",
        assets = {
            Asset("ANIM", "anim/tbat_dreamsea_coral_hhly.zip"),
        },
    }
)

-- 幻海珊瑚-幻海心贝
BOOKOFALLTHINGS.MakeItemSkinDefaultImage("tbat_dreamsea_coral", "images/tbat_inventoryimages.xml", "tbat_dreamsea_coral_hhxb")
BOOKOFALLTHINGS.MakeItemSkin(
    "tbat_dreamsea_coral",
    "tbat_dreamsea_coral_hhxb",
    {
        name = STRINGS.TBAT_STRINGS.TBAT_DREAMSEA_CORAL_HHXB_NAME,
        des = "None",
        rarity = "tbat_purple",
        raritycorlor = { 238 / 255, 130 / 255, 238 / 255, 1 }, -- purple
        atlas = "images/tbat_inventoryimages.xml",
        image = "tbat_dreamsea_coral_hhxb",
        build = "tbat_dreamsea_coral_hhxb",
        bank = "tbat_dreamsea_coral_hhxb",
        basebuild = "tbat_dreamsea_coral",
        basebank = "tbat_dreamsea_coral",
        assets = {
            Asset("ANIM", "anim/tbat_dreamsea_coral_hhxb.zip"),
        },
    }
)

-- 织梦桃云树-听风紫萝藤
BOOKOFALLTHINGS.MakeItemSkinDefaultImage("tbat_dreamweaver_peachcloud_tree", "images/tbat_inventoryimages.xml", "tbat_dreamweaver_peachcloud_tree_tfzlt")
BOOKOFALLTHINGS.MakeItemSkin(
    "tbat_dreamweaver_peachcloud_tree",
    "tbat_dreamweaver_peachcloud_tree_tfzlt",
    {
        name = STRINGS.TBAT_STRINGS.TBAT_DREAMWEAVER_PEACHCLOUD_TREE_TFZLT_NAME,
        des = "None",
        rarity = "tbat_pink",
        raritycorlor = { 255 / 255, 192 / 255, 203 / 255, 1 }, -- pink
        atlas = "images/tbat_inventoryimages.xml",
        image = "tbat_dreamweaver_peachcloud_tree_tfzlt",
        build = "tbat_dreamweaver_peachcloud_tree_tfzlt",
        bank = "tbat_dreamweaver_peachcloud_tree_tfzlt",
        basebuild = "tbat_dreamweaver_peachcloud_tree",
        basebank = "tbat_dreamweaver_peachcloud_tree",
        assets = {
            Asset("ANIM", "anim/tbat_dreamweaver_peachcloud_tree_tfzlt.zip"),
        },
    }
)

-- 幻灵水池-欢闹池塘
BOOKOFALLTHINGS.MakeItemSkinDefaultImage("tbat_spirit_pool", "images/tbat_inventoryimages.xml", "tbat_spirit_pool_hnct")
BOOKOFALLTHINGS.MakeItemSkin(
    "tbat_spirit_pool",
    "tbat_spirit_pool_hnct",
    {
        name = STRINGS.TBAT_STRINGS.TBAT_SPIRIT_POOL_HNCT_NAME,
        des = "None",
        rarity = "tbat_pink",
        raritycorlor = { 255 / 255, 192 / 255, 203 / 255, 1 }, -- pink
        atlas = "images/tbat_inventoryimages.xml",
        image = "tbat_spirit_pool_hnct",
        build = "tbat_spirit_pool_hnct",
        bank = "tbat_spirit_pool_hnct",
        basebuild = "tbat_spirit_pool",
        basebank = "tbat_spirit_pool",
        assets = {
            Asset("ANIM", "anim/tbat_spirit_pool_hnct.zip"),
        },
        init_fn = function(inst, skinname)
            if inst.components.container then
                inst.components.container:Close()
                inst._container:set(1)
                inst.components.container:WidgetSetup("tbat_spirit_pool_hnct")
            end
        end,
        clear_fn = function(inst, skinname)
            if inst.components.container then
                inst.components.container:Close()
                inst._container:set(0)
                inst.components.container:WidgetSetup("tbat_spirit_pool")
            end
        end,
    }
)

-- 绿野摇摇椅-彩虹暖阳摇椅
BOOKOFALLTHINGS.MakeItemSkinDefaultImage("tbat_meadow_rocking_chair", "images/tbat_inventoryimages.xml", "tbat_meadow_rocking_chair_chnyyy")
BOOKOFALLTHINGS.MakeItemSkin(
    "tbat_meadow_rocking_chair",
    "tbat_meadow_rocking_chair_chnyyy",
    {
        name = STRINGS.TBAT_STRINGS.TBAT_MEADOW_ROCKING_CHAIR_CHNYYY_NAME,
        des = "None",
        rarity = "tbat_purple",
        raritycorlor = { 238 / 255, 130 / 255, 238 / 255, 1 }, -- purple
        atlas = "images/tbat_inventoryimages.xml",
        image = "tbat_meadow_rocking_chair_chnyyy",
        build = "tbat_meadow_rocking_chair_chnyyy",
        bank = "tbat_meadow_rocking_chair_chnyyy",
        basebuild = "tbat_meadow_rocking_chair",
        basebank = "tbat_meadow_rocking_chair",
        assets = {
            Asset("ANIM", "anim/tbat_meadow_rocking_chair_chnyyy.zip"),
        },
    }
)
