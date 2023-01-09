extends Resource
class_name Stat

@export var base_value = 1.0
@export var level_bonus = 0.0

var item_modifier = 0.0

func apply_level_bonus(bonus):
	level_bonus += bonus

func apply_item_modifier(modifier):
	item_modifier = modifier

func get_effective_value(level, multiplier = 1) -> float:
	return (base_value + (level_bonus * (level - 1)) + item_modifier) * multiplier

func _init(p_bv = 1, p_lb = 0, p_im = 0):
	base_value = p_bv
	level_bonus = p_lb
	item_modifier = p_im

	
