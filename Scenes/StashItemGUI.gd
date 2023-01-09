extends Control

var item = null

func set_item(item : Item, amount: int):
	self.item = item
	$ItemIcon.texture = item.icon
	$ItemAmount.text = str(amount)
	pass
