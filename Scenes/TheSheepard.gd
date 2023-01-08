extends "res://Scenes/ControllablePlayer.gd"

func modify_skill(skill):
	super.modify_skill(skill)
	skill.buff_amount = player_stats.get_skill_scaling()
	
func on_attack_damage(damage):
	var players = get_tree().get_nodes_in_group("player")
	for player in players:
		player.modify_health(damage * player_stats.get_passive())
	pass
