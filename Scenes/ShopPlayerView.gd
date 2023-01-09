extends Control

@export var player_stats: PlayerStats
@onready var shop = get_tree().get_first_node_in_group("shop")
func _ready():
	$CandidateSelect.visible = false
	
func update():
	var child = 0
	for item in player_stats.inventory.items:
		var amount =player_stats.inventory.items[item]
		var disp = $InventoryDisplay.get_child(child)
		disp.set_item(item, amount)
		disp.player_stats = player_stats
		child += 1
	
	while child < $InventoryDisplay.get_child_count():
		var disp = $InventoryDisplay.get_child(child)
		disp.clear()
		child += 1
	pass

func enable_candidate_mode():
	if player_stats.can_add_to_inventory():
		$CandidateSelect.visible = true
	pass
	
func disable_candidate_mode():
	$CandidateSelect.visible = false
	update()
	pass

func _on_button_pressed():
	shop.use_candidate(player_stats)
	pass # Replace with function body.
