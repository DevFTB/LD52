extends Label


func _on_combat_on_arena_changed(round, zone):
	text = zone.zone_name +  " " + str(round + 1)
	pass # Replace with function body.
