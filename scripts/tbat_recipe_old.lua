-- 幻灵水池
AddRecipe2(
    "tbat_spirit_pool",
    {
        Ingredient("tbat_item_crystal_bubble", 10),
        Ingredient("tbat_reef_conch", 10),
        Ingredient("tbat_material_memory_crystal", 20)
    },
    TECH.TBAT_THE_TREE_OF_ALL_THINGS_ONE,
    {
        placer = "tbat_spirit_pool_placer", -- 建造预览
        min_spacing = 0,                    -- 放置间隔
    },
    {
        "TBAT_RECIPE_FILTER_BUILDING", -- 模组建筑分类
    }
)

-- 绿野摇摇椅
AddRecipe2(
    "tbat_meadow_rocking_chair",
    {
        Ingredient("tbat_plant_fluorescent_mushroom_item", 6),
        Ingredient("tbat_material_miragewood", 10),
    },
    TECH.TBAT_THE_TREE_OF_ALL_THINGS_ONE,
    {
        placer = "tbat_meadow_rocking_chair_placer",
        min_spacing = 0,
    },
    {
        "TBAT_RECIPE_FILTER_DECORATION",
    }
)

-- 小径石板
AddRecipe2(
    "tbat_pathway_slab_item",
    { Ingredient("tbat_material_memory_crystal", 1) },
    TECH.TBAT_THE_TREE_OF_ALL_THINGS_ONE,
    {
        numtogive = 6,
    },
    {
        "TBAT_RECIPE_FILTER_DECORATION",
    }
)

-- 暖蔷篱笆栅栏
AddRecipe2(
    "tbat_cozy_rosebush_fence_item",
    { Ingredient("tbat_material_miragewood", 2), Ingredient("tbat_food_pear_blossom_petals", 2) },
    TECH.TBAT_THE_TREE_OF_ALL_THINGS_ONE,
    {
        numtogive = 4,
    },
    {
        "TBAT_RECIPE_FILTER_DECORATION",
    }
)

-- 玫瑰木架栅栏
AddRecipe2(
    "tbat_rose_trellis_fence_item",
    { Ingredient("tbat_material_miragewood", 2), Ingredient("tbat_food_valorbush", 2) },
    TECH.TBAT_THE_TREE_OF_ALL_THINGS_ONE,
    {
        numtogive = 4,
    },
    {
        "TBAT_RECIPE_FILTER_DECORATION",
    }
)

-- 织梦桃云树
AddRecipe2(
    "tbat_dreamweaver_peachcloud_tree",
    { Ingredient("tbat_food_fantasy_peach_seeds", 10) },
    TECH.TBAT_THE_TREE_OF_ALL_THINGS_ONE,
    {
        placer = "tbat_dreamweaver_peachcloud_tree_placer",
        min_spacing = 0,
    },
    {
        "TBAT_RECIPE_FILTER_DECORATION",
    }
)
