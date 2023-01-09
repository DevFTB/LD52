extends Control

@export var item = null

@export var tooltip_path : NodePath
@onready var tooltip = get_node(tooltip_path)
@export var slot = 0
signal buy_pressed(item, slot)

func _ready():
	visible = false

func set_item(item):
	if item != null:
		$TextureRect.texture = item.icon
		$TextureButton/Label.text = str(item.cost)
		self.item = item
		visible =true
	pass

func _on_buy_button_pressed():
	if item != null:
		emit_signal("buy_pressed", item, slot)
		$Click.play()
	# TODO
	pass # Replace with function body.


func _on_texture_rect_mouse_entered():
	tooltip.show_tooltip(item, self)
	pass # Replace with function body.


func _on_texture_rect_mouse_exited():
	if not Rect2(Vector2(), $TextureRect.size).has_point($TextureRect.get_local_mouse_position()):
		tooltip.hide_tooltip(self)
	pass # Replace with function body.
