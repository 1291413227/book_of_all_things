-- 幻灵水池
AddRecipe2(
    "tbat_spirit_pool",
    { Ingredient("goldnugget", 1) }, -- 配方
    TECH.SCIENCE_TWO,
    {
        placer = "tbat_spirit_pool_placer", -- 建造预览
        min_spacing = 1,                    -- 放置间隔
    },
    {
        "STRUCTURES", -- 建筑分类
        "FISHING",    -- 钓鱼分类
    }
)
