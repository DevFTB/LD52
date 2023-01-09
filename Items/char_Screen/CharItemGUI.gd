extends "res://Scenes/StashItemGUI.gd"

var player_stats : PlayerStats

func _gui_input(event):
	
	if event is InputEventMouseButton:
		if event.is_double_click():
			print("dbl_click")
			if item != null:
				shop.remove_item_from_player(player_stats, item)
	
	pass
