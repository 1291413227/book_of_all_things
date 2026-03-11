-- 幻灵水池
AddRecipe2(
    "tbat_spirit_pool",
    { Ingredient("goldnugget", 1) }, -- 配方
    TECH.SCIENCE_TWO,
    {
        placer = "tbat_spirit_pool_placer", -- 建造预览
        min_spacing = 0,                    -- 放置间隔
    },
    {
        "STRUCTURES", -- 建筑分类
        "FISHING",    -- 钓鱼分类
    }
)

-- 绿野摇摇椅
AddRecipe2(
    "tbat_meadow_rocking_chair",
    { Ingredient("goldnugget", 1) },
    TECH.SCIENCE_TWO,
    {
        placer = "tbat_meadow_rocking_chair_placer",
        min_spacing = 0,
    },
    {
        "STRUCTURES",
    }
)

-- 小径石板
AddRecipe2(
    "tbat_pathway_slab_item",
    { Ingredient("goldnugget", 1) },
    TECH.SCIENCE_TWO,
    {
        numtogive = 6,
    },
    {
        "DECOR",
    }
)

-- 暖蔷篱笆栅栏
AddRecipe2(
    "tbat_cozy_rosebush_fence_item",
    { Ingredient("goldnugget", 1) },
    TECH.SCIENCE_TWO,
    {
        numtogive = 4,
    },
    {
        "STRUCTURES",
    }
)

-- 玫瑰木架栅栏
AddRecipe2(
    "tbat_rose_trellis_fence_item",
    { Ingredient("goldnugget", 1) },
    TECH.SCIENCE_TWO,
    {
        numtogive = 4,
    },
    {
        "STRUCTURES",
    }
)

-- 织梦桃云树
AddRecipe2(
    "tbat_dreamweaver_peachcloud_tree",
    { Ingredient("goldnugget", 10) },
    TECH.SCIENCE_TWO,
    {
        placer = "tbat_dreamweaver_peachcloud_tree_placer",
        min_spacing = 0,
    },
    {
        "STRUCTURES",
        "DECOR",
    }
)
