extends Node

@export var game_progression : GameProgression
@export var slot1 : Control
@export var slot2 : Control
@export var slot3 : Control
@export var currency_label : Label
@export var stash_gui: Control
func _ready():
	regenerate_shop()
	update_gui()
	pass

func regenerate_shop():
	var current_zone = game_progression.get_current_zone()
	slot1.set_item(select_item(current_zone.shop_slot_1))
	slot2.set_item(select_item(current_zone.shop_slot_2))
	slot3.set_item(select_item(current_zone.shop_slot_3))
	pass

func select_item(distribution):
	var rarity = select_rarity(distribution)
	var selectable_items = game_progression.items.filter(func(i): return i.rarity == rarity)
	if selectable_items.size() > 0:
		return selectable_items[randi() % selectable_items.size()]
	else:
		return null
	
func select_rarity(distribution) -> int:
	var rarities  = range(5)
	
	var rand = randf()
	var total = 0.0
	for rarity in rarities:
		total += distribution[rarity]
		if rand < total:
			return rarity
	
	return Item.Rarity.MYTHIC


func _on_refresh_button_pressed():
	if game_progression.current_money >= 2:
		game_progression.current_money -= 2
		regenerate_shop()
		update_gui()
	pass # Replace with function body.

func update_gui():
	currency_label.text = str(game_progression.current_money)
	stash_gui.update(game_progression.stash)

func _on_buy_pressed(item, slot):
	if item != null:
		if game_progression.current_money >= item.cost:
				game_progression.current_money -= item.cost
				game_progression.stash.add(item)
				match(slot):
					0:
						slot1.set_item(select_item(game_progression.get_current_zone().shop_slot_1))
					1:
						slot2.set_item(select_item(game_progression.get_current_zone().shop_slot_2))
					2:
						slot3.set_item(select_item(game_progression.get_current_zone().shop_slot_3))				
				
				update_gui()
	pass # Replace with function body.
