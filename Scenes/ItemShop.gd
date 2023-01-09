extends Node

@export var game_progression : GameProgression
@export var slot1 : Control
@export var slot2 : Control
@export var slot3 : Control
@export var currency_label : Label
@export var stash_gui: Control

@export var voice_lines = ["Come browse my wares.", "Quality goods at low prices!", "I keep this for my most prized customers", "Someone acutally gifted these items to me.", "I never expected my food to start fighting back!"]

var candidate_item = null

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

func update_player_views():
	for view in $CharacterScreen/PlayerViews.get_children():
		view.update()

func _on_character_button_pressed():
	$CharacterScreen.visible = not $CharacterScreen.visible
	stash_gui.set_char_mode($CharacterScreen.visible)
	pass # Replace with function body.

func set_player_candidate_item(item: Item):
	candidate_item = item
	for view in $CharacterScreen/PlayerViews.get_children():
		view.enable_candidate_mode()
	pass

func use_candidate(player_stats):
	if candidate_item != null:
		player_stats.add_item(candidate_item)
		game_progression.stash.remove(candidate_item)
		
		update_gui()
		
	for view in $CharacterScreen/PlayerViews.get_children():
		view.disable_candidate_mode()
		
	candidate_item = null
		
func remove_item_from_player(player_stats: PlayerStats, item: Item):
	player_stats.inventory.remove(item)
	game_progression.stash.add(item)
	update_gui()
	update_player_views()
	
func _input(event):
	if event.is_action_pressed("deselect") and candidate_item != null:
		candidate_item = null


func _on_next_stage_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Combat.tscn")
	pass # Replace with function body.


func _on_timer_timeout():
	$ItemShopGUI/TextBox2/SpeechLabel.display_text(voice_lines[randi() % voice_lines.size()])
	pass # Replace with function body.
