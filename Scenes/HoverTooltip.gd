extends Control

func _process(delta):
	if visible:
		position = get_viewport().get_mouse_position()
	pass

func show_tooltip(item):
	visible = true
	if item != null:
		$Name.text = item.item_name
	pass
	
func hide_tooltip():
	visible = false
	
	$Name.text = ""
	pass
