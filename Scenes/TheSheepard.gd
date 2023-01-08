extends "res://Scenes/ControllablePlayer.gd"

func modify_skill(skill):
	super.modify_skill(skill)
	skill.buff_amount = player_stats.get_skill_scaling()
