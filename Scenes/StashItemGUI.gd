extends Control

var item = null
var char_mode = false
@onready var tooltip = get_tree().get_first_node_in_group("tooltip")
@onready var shop = get_tree().get_first_node_in_group("shop")
func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	gui_input.connect(on_gui_input)
	pass

func set_item(item : Item, amount: int):
	self.item = item
	$ItemIcon.texture = item.icon
	$ItemAmount.text = str(amount)
	pass

func _on_mouse_entered():
	if item != null:
		tooltip.show_tooltip(item, self)
	pass # Replace with function body.

func clear():
	$ItemIcon.texture = null
	$ItemAmount.text = ""
	
func _on_mouse_exited():
	if item != null:
		if not Rect2(Vector2(),size).has_point(get_local_mouse_position()):
			tooltip.hide_tooltip(self)
	pass # Replace with function body.

func on_gui_input(event):
	if event is InputEventMouseButton:
		print(str(event is InputEventMouseButton) + ", " + str(event.button_index == MOUSE_BUTTON_LEFT) + ", " + str(event.pressed))
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if char_mode and item != null:
				shop.set_player_candidate_item(item)
		pass
	pass
