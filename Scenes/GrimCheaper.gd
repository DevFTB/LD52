extends "res://Scenes/ControllablePlayer.gd"

func on_attack_damage(damage):
	modify_health(damage * player_stats.get_passive())
	pass

func get_skill_damage():
	return atk * player_stats.get_attack_scaling()

func modify_skill(skill):
	super.modify_skill(skill)
	skill.max_amount = player_stats.get_skill_scaling()
