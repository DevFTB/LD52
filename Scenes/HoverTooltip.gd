extends Control

var current_control = null

func _process(delta):
	if visible:
		position = get_viewport().get_mouse_position()
	pass

func show_tooltip(item, control: Control):
	visible = true
	current_control = control
	if item != null:
		$Name.text = item.item_name
	pass
	
func hide_tooltip(control: Control):
	if control == current_control:
		visible = false
		
		$Name.text = ""
		pass
