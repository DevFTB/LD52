extends "res://Player/Abilities/BuffStats.gd"

func stack_with(stats: BuffStats) -> BuffStats:
	return BuffStats.new(hp + stats.hp, atk + stats.atk, atk_speed + stats.atk_speed, move_speed + stats.move_speed, dmg_reduction + stats.dmg_reduction)
	pass 
