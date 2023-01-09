extends Resource
class_name Zone

@export var zone_name = "Zone"
@export var enemies : Array[EnemyGroup] = []
@export var zone_scenes : Array[PackedScene] = []
@export var difficulty_levels : Array[int] = []

const default_shop_slot = {
	Item.Rarity.COMMON: 1.0,
	Item.Rarity.RARE: 0.0,
	Item.Rarity.EPIC: 0.0,
	Item.Rarity.LEGENDARY: 0.0,
	Item.Rarity.MYTHIC: 0.0,
}

@export var shop_slot_1 = default_shop_slot
@export var shop_slot_2 = default_shop_slot
@export var shop_slot_3 = default_shop_slot

@export var currency_multiplier = 1

func _init(p_zn = "Zone", p_en = [], p_zs = [], p_dl = [], p_ss1 = default_shop_slot, p_ss2 = default_shop_slot, p_ss3 = default_shop_slot, p_cm = 1):
		zone_name = p_zn
		enemies = p_en
		zone_scenes = p_zs
		difficulty_levels = p_dl
		shop_slot_1 = p_ss1
		shop_slot_2 = p_ss2
		shop_slot_3 = p_ss3
		currency_multiplier = p_cm
