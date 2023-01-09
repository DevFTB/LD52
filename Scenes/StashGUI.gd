extends Control

var stash_item_gui = preload("res://Items/item_shop/stash_item_gui.tscn")
@export var row_amount = 10

func _ready():
	for i in range(row_amount):
		$TopRow.add_child(stash_item_gui.instantiate())
	for i in range(row_amount):
		$BottomRow.add_child(stash_item_gui.instantiate())
	pass

func update(inventory: Inventory):
	var row = 0
	for item in inventory.items.keys():
		var amount = inventory.items[item]
		
		if row % 2 == 0:
			$TopRow.get_child(row / 2).set_item(item, amount)
		else:
			$BottomRow.get_child(row - 1 / 2).set_item(item, amount)
		
		row += 1
	pass
