extends Control

var item = null

@onready var tooltip = get_tree().get_first_node_in_group("tooltip")

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
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


func _on_mouse_exited():
	if item != null:
		if not Rect2(Vector2(),size).has_point(get_local_mouse_position()):
			tooltip.hide_tooltip(self)
	pass # Replace with function body.
