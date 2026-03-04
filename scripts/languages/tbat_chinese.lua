-- 物品
for i = 1, 39 do
    STRINGS.NAMES["TBAT_ITEM_NOTES_OF_ADVENTURER_" .. i] = "冒险家笔记" .. "·" .. i
    STRINGS.CHARACTERS.GENERIC.DESCRIBE["TBAT_ITEM_NOTES_OF_ADVENTURER_" .. i] = "这是谁留下的？也许应该问问那只绿色的大鸟。"
end

-- 动作
STRINGS.TBAT_ACTIONS = {}

STRINGS.TBAT_ACTIONS.TBAT_READ = {
    GENERIC = "阅读",
}
