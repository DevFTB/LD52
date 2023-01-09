extends Control

@export var item = null

@export var tooltip_path : NodePath
@onready var tooltip = get_node(tooltip_path)

func set_item(item):
	$TextureRect.texture = item.icon
	pass

func _on_buy_button_pressed():
	# TODO
	pass # Replace with function body.


func _on_texture_rect_mouse_entered():
	tooltip.show_tooltip(item)
	pass # Replace with function body.


func _on_texture_rect_mouse_exited():
	if not Rect2(Vector2(), size).has_point(get_local_mouse_position()):
		tooltip.hide_tooltip()
	pass # Replace with function body.
