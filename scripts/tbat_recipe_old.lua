-- 本mod自己的科技靠近指定建筑或者物品解锁
AddPrototyperDef("tbat_rose_twin_goose", { -- 玫瑰双生鹅
    icon_atlas = "images/tbat_crafting_menu_icons.xml",
    icon_image = "station_tbat_rose_twin_goose.tex",
    is_crafting_station = true,
    action_str = "TBAT_TWIN_GOOSE",
    filter_text = STRINGS.UI.CRAFTING_STATION_FILTERS.TBAT_TWIN_GOOSE,
})

local function CanPlaceRoseTwinGoose(pt, rot)
    if TheWorld ~= nil and TheWorld.GetTBATTwinGooseLevel ~= nil then
        return TheWorld:GetTBATTwinGooseLevel() < 1
    end

    return TheSim == nil or TheSim:FindFirstEntityWithTag("tbat_rose_twin_goose") == nil
end

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
        min_spacing = 0.5,                  -- 放置间隔
    },
    {
        "TBAT_RECIPE_FILTER_BUILDING", -- 模组建筑分类
    }
)
RemoveRecipeFromFilter("tbat_spirit_pool", "MODS")

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
        min_spacing = 0.5,
    },
    {
        "TBAT_RECIPE_FILTER_DECORATION",
    }
)
RemoveRecipeFromFilter("tbat_meadow_rocking_chair", "MODS")

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
RemoveRecipeFromFilter("tbat_pathway_slab_item", "MODS")

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
RemoveRecipeFromFilter("tbat_cozy_rosebush_fence_item", "MODS")

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
RemoveRecipeFromFilter("tbat_rose_trellis_fence_item", "MODS")

-- 织梦桃云树
AddRecipe2(
    "tbat_dreamweaver_peachcloud_tree",
    { Ingredient("tbat_food_fantasy_peach_seeds", 10) },
    TECH.TBAT_THE_TREE_OF_ALL_THINGS_ONE,
    {
        placer = "tbat_dreamweaver_peachcloud_tree_placer",
        min_spacing = 0.5,
    },
    {
        "TBAT_RECIPE_FILTER_DECORATION",
    }
)
RemoveRecipeFromFilter("tbat_dreamweaver_peachcloud_tree", "MODS")

-- 月光记忆晶泉
AddRecipe2(
    "tbat_moonlit_memory_crystal_spring",
    {
        Ingredient("tbat_material_memory_crystal", 60),
        Ingredient("tbat_item_crystal_bubble", 2),
        Ingredient("tbat_plant_coconut_cat_fruit", 1),
    },
    TECH.TBAT_THE_TREE_OF_ALL_THINGS_ONE,
    {
        placer = "tbat_moonlit_memory_crystal_spring_placer",
        min_spacing = 0.5,
    },
    {
        "TBAT_RECIPE_FILTER_DECORATION",
    }
)
RemoveRecipeFromFilter("tbat_moonlit_memory_crystal_spring", "MODS")

-- 晓光玫瑰藤蔓
AddRecipe2(
    "tbat_vine_rose",
    {
        Ingredient("tbat_food_valorbush", 2),
    },
    TECH.TBAT_THE_TREE_OF_ALL_THINGS_ONE,
    {
        placer = "tbat_vine_rose_placer",
        min_spacing = 0.5,
    },
    {
        "TBAT_RECIPE_FILTER_DECORATION",
    }
)
RemoveRecipeFromFilter("tbat_vine_rose", "MODS")

-- 幻海珊瑚
AddRecipe2(
    "tbat_dreamsea_coral",
    {
        Ingredient("tbat_material_memory_crystal", 6),
    },
    TECH.TBAT_THE_TREE_OF_ALL_THINGS_ONE,
    {
        placer = "tbat_dreamsea_coral_placer",
        min_spacing = 0.5,
    },
    {
        "TBAT_RECIPE_FILTER_DECORATION",
    }
)
RemoveRecipeFromFilter("tbat_dreamsea_coral", "MODS")

-- 浮梦落雪地皮
AddRecipe2(
    "turf_tbat_snowfall",
    {
        Ingredient("tbat_material_wish_token", 1),
        Ingredient("tbat_food_pear_blossom_petals", 2),
    },
    TECH.TBAT_THE_TREE_OF_ALL_THINGS_ONE,
    {
        numtogive = 8,
    },
    {
        "TBAT_RECIPE_FILTER_DECORATION",
    }
)
RemoveRecipeFromFilter("turf_tbat_snowfall", "MODS")

-- 幻彩云间地皮
AddRecipe2(
    "turf_tbat_cloud",
    {
        Ingredient("tbat_material_dandelion_umbrella", 1),
        Ingredient("tbat_material_dandycat", 2),
    },
    TECH.TBAT_THE_TREE_OF_ALL_THINGS_ONE,
    {
        numtogive = 8,
    },
    {
        "TBAT_RECIPE_FILTER_DECORATION",
    }
)
RemoveRecipeFromFilter("turf_tbat_cloud", "MODS")

-- 灵蝶幻境地皮
AddRecipe2(
    "turf_tbat_psylocke",
    {
        Ingredient("tbat_animal_ephemeral_butterfly", 1),
        Ingredient("tbat_food_cherry_blossom_petals", 2),
    },
    TECH.TBAT_THE_TREE_OF_ALL_THINGS_ONE,
    {
        numtogive = 8,
    },
    {
        "TBAT_RECIPE_FILTER_DECORATION",
    }
)
RemoveRecipeFromFilter("turf_tbat_psylocke", "MODS")

-- 绿野森林地皮
AddRecipe2(
    "turf_tbat_forest",
    {
        Ingredient("tbat_plant_dandycat_kit", 1),
        Ingredient("tbat_food_lavender_flower_spike", 2),
    },
    TECH.TBAT_THE_TREE_OF_ALL_THINGS_ONE,
    {
        numtogive = 8,
    },
    {
        "TBAT_RECIPE_FILTER_DECORATION",
    }
)
RemoveRecipeFromFilter("turf_tbat_forest", "MODS")

-- 玫瑰双生鹅
AddRecipe2(
    "tbat_rose_twin_goose",
    {
        Ingredient("tbat_plant_valorbush_kit", 9),
        Ingredient("tbat_material_starshard_dust", 9),
        Ingredient("tbat_material_emerald_feather", 2)
    },
    TECH.TBAT_THE_TREE_OF_ALL_THINGS_ONE,
    {
        placer = "tbat_rose_twin_goose_placer",
        min_spacing = 0.5,
        testfn = CanPlaceRoseTwinGoose,
    },
    {
        "TBAT_RECIPE_FILTER_BUILDING",
    }
)
RemoveRecipeFromFilter("tbat_rose_twin_goose", "MODS")

-- 玫瑰小鹅蛋
AddRecipe2(
    "tbat_rose_goose_egg",
    {
        Ingredient("tbat_plant_valorbush_kit", 2),
    },
    TECH.TBAT_TWIN_GOOSE_TECH_ONE,
    {
        nounlock = true
    },
    {
        "TBAT_RECIPE_FILTER_ITEM",
    }
)
RemoveRecipeFromFilter("tbat_rose_goose_egg", "MODS")

-- 萌宠洗衣机
AddRecipe2(
    "tbat_pet_washer",
    {
        Ingredient("tbat_material_lavender_laundry_detergent", 5),
        Ingredient("tbat_material_wish_token", 5),
        Ingredient("tbat_material_memory_crystal", 20)
    },
    TECH.TBAT_THE_TREE_OF_ALL_THINGS_ONE,
    {
        placer = "tbat_pet_washer_placer",
        min_spacing = 0.5,
    },
    {
        "TBAT_RECIPE_FILTER_BUILDING",
    }
)
RemoveRecipeFromFilter("tbat_pet_washer", "MODS")
