extends "res://Player/Abilities/BuffAttack.gd"

var dmg_reduction = 0
var final_heal = 0

func buff():
	source_player.apply_buff(BuffStats.new(1,1,1,1,dmg_reduction), duration)
	pass

func do_final_action():
	source_player.modify_health(final_heal)
	pass
