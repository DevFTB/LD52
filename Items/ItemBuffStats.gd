extends Resource

class_name ItemBuffStats
@export var hp = 0.0
@export var atk = 0.0
@export var atk_speed = 0.0
@export var move_speed = 0.0
@export var dmg_reduction = 0.0
@export var skill_cooldown = 0.0
func stack_with(stats: ItemBuffStats) -> ItemBuffStats:
	return ItemBuffStats.new(hp + stats.hp, atk + stats.atk, atk_speed + stats.atk_speed, move_speed + stats.move_speed, dmg_reduction + stats.dmg_reduction)

func _init(p_hp = 0.0, p_atk = 0.0, p_atk_speed = 0.0, p_ms = 0.0, p_dr = 0.0, p_sc = 0.0):
	hp = p_hp
	atk = p_atk
	atk_speed = p_atk_speed
	move_speed = p_ms
	dmg_reduction = p_dr
	skill_cooldown = p_sc
