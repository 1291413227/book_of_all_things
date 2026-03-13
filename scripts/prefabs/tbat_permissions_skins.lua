-- 小浣熊木牌-9款权限皮肤
local sign_skins = {
    "mira",
    "fufu",
    "cass",
    "yijiu",
    "club",
    "leci",
    "suyin",
    "xmm",
    "yaobao",
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
