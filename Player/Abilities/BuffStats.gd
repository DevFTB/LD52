extends Resource
class_name BuffStats

@export var hp = 1.0
@export var atk = 1.0
@export var atk_speed = 1.0
@export var move_speed = 1.0
@export var dmg_reduction = 0.0
@export var skill_cooldown = 1.0

func stack_with(stats: BuffStats) -> BuffStats:
	return BuffStats.new(hp + stats.hp - 1, atk + stats.atk - 1, atk_speed + stats.atk_speed - 1, move_speed + stats.move_speed - 1, dmg_reduction + stats.dmg_reduction, skill_cooldown + stats.skill_cooldown - 1)
	pass 

func _init(p_hp = 1.0, p_atk = 1.0, p_atk_speed = 1.0, p_ms = 1.0, p_dr = 0.0, p_sc = 1.0):
	hp = p_hp
	atk = p_atk
	atk_speed = p_atk_speed
	move_speed = p_ms
	dmg_reduction = p_dr
	skill_cooldown = p_sc
	
func apply_to(player):
	player.hp = player.player_stats.get_hp() * hp
	player.atk = player.player_stats.get_atk() * atk
	player.atk_speed = player.player_stats.get_atk_speed() * atk_speed
	player.move_speed = player.player_stats.get_move_speed() * move_speed
	player.dmg_reduction = dmg_reduction
