class_name BuffStats

var hp = 1
var atk = 1
var atk_speed = 1
var move_speed = 1

func stack_with(stats: BuffStats) -> BuffStats:
	return BuffStats.new(hp + stats.hp - 1, atk + stats.atk - 1, atk_speed + stats.atk_speed - 1, move_speed + stats.move_speed - 1)
	pass 

func _init(p_hp = 1, p_atk = 1, p_atk_speed = 1, p_ms = 1):
	hp = p_hp
	atk = p_atk
	atk_speed = p_atk_speed
	move_speed = p_ms
	
func apply_to(player):
	player.hp = player.player_stats.get_hp() * hp
	player.atk = player.player_stats.get_atk() * atk
	player.atk_speed = player.player_stats.get_atk_speed() * atk_speed
	player.move_speed = player.player_stats.get_move_speed() * move_speed
