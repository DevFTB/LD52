extends "res://Scenes/ControllablePlayer.gd"

func modify_skill(skill):
	skill.dmg_reduction = player_stats.get_skill_scaling()
	skill.final_heal = player_stats.get_hp() * player_stats.get_skill_scaling()
	pass

func recalculate_stats():
	super.recalculate_stats()
	dmg_reduction += player_stats.get_passive()

