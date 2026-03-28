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
    { Ingredient("goldnugget", 1) }, -- 配方
    TECH.SCIENCE_TWO,
    {
        placer = "tbat_spirit_pool_placer", -- 建造预览
        min_spacing = 0.5,                  -- 放置间隔
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
        min_spacing = 0.5,
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
    { Ingredient("goldnugget", 1) },
    TECH.SCIENCE_TWO,
    {
        placer = "tbat_dreamweaver_peachcloud_tree_placer",
        min_spacing = 0.5,
    },
    {
        "STRUCTURES",
        "DECOR",
    }
)

-- 月光记忆晶泉
AddRecipe2(
    "tbat_moonlit_memory_crystal_spring",
    { Ingredient("goldnugget", 1), },
    TECH.SCIENCE_TWO,
    {
        placer = "tbat_moonlit_memory_crystal_spring_placer",
        min_spacing = 0.5,
    },
    {
        "STRUCTURES",
    }
)

-- 晓光玫瑰藤蔓
AddRecipe2(
    "tbat_vine_rose",
    {
        Ingredient("goldnugget", 1),
    },
    TECH.SCIENCE_TWO,
    {
        placer = "tbat_vine_rose_placer",
        min_spacing = 0.5,
    },
    {
        "STRUCTURES",
    }
)

-- 幻海珊瑚
AddRecipe2(
    "tbat_dreamsea_coral",
    {
        Ingredient("goldnugget", 1),
    },
    TECH.SCIENCE_TWO,
    {
        placer = "tbat_dreamsea_coral_placer",
        min_spacing = 0.5,
    },
    {
        "STRUCTURES",
    }
)

-- 浮梦落雪地皮
AddRecipe2(
    "turf_tbat_snowfall",
    {
        Ingredient("goldnugget", 1),
    },
    TECH.SCIENCE_TWO,
    {
        numtogive = 8,
    },
    {
        "DECOR",
    }
)

-- 幻彩云间地皮
AddRecipe2(
    "turf_tbat_cloud",
    {
        Ingredient("goldnugget", 1),
    },
    TECH.SCIENCE_TWO,
    {
        numtogive = 8,
    },
    {
        "DECOR",
    }
)

-- 灵蝶幻境地皮
AddRecipe2(
    "turf_tbat_psylocke",
    {
        Ingredient("goldnugget", 1),
    },
    TECH.SCIENCE_TWO,
    {
        numtogive = 8,
    },
    {
        "DECOR",
    }
)

-- 绿野森林地皮
AddRecipe2(
    "turf_tbat_forest",
    {
        Ingredient("goldnugget", 1),
    },
    TECH.SCIENCE_TWO,
    {
        numtogive = 8,
    },
    {
        "DECOR",
    }
)

-- 玫瑰双生鹅
AddRecipe2(
    "tbat_rose_twin_goose",
    {
        Ingredient("goldnugget", 1),
    },
    TECH.SCIENCE_TWO,
    {
        placer = "tbat_rose_twin_goose_placer",
        min_spacing = 0.5,
        testfn = CanPlaceRoseTwinGoose,
    },
    {
        "STRUCTURES",
    }
)

-- 玫瑰小鹅蛋
AddRecipe2(
    "tbat_rose_goose_egg",
    {
        Ingredient("goldnugget", 1),
    },
    TECH.TBAT_TWIN_GOOSE_TECH_ONE,
    {
        nounlock = true
    },
    {
        "MAGIC",
    }
)

-- 萌宠洗衣机
AddRecipe2(
    "tbat_pet_washer",
    {
        Ingredient("goldnugget", 1),
    },
    TECH.SCIENCE_TWO,
    {
        placer = "tbat_pet_washer_placer",
        min_spacing = 0.5,
    },
    {
        "STRUCTURES",
    }
)
