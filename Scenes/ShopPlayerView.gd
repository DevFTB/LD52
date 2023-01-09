extends Control

@export var player_stats: PlayerStats
@onready var shop = get_tree().get_first_node_in_group("shop")
func _ready():
	$CandidateSelect.visible = false
	$Control/TextureRect.texture = player_stats.player_portrait
	update()
	
func update():
	$Control/Control/LevelLabel.text = "Level: " + str(player_stats.get_level())
	$Control/Control/USPLabel.text = "Skill points: " + str(player_stats.unused_skill_points)
	$Control/Control/Attack/Label.text =  	"Attack:  " + str(player_stats.attack_level)
	$Control/Control/Skill/Label.text =  	"Skill:   " + str(player_stats.skill_level)
	$Control/Control/Passive/Label.text =  	"Passive: " + str(player_stats.passive_level)
	
	var can_upgrade = player_stats.unused_skill_points > 0
	$Control/Control/Attack/AddAttackLevelButton.visible = can_upgrade
	$Control/Control/Skill/AddSkillLevelButton.visible = can_upgrade
	$Control/Control/Passive/AddPassiveLevelButton.visible = can_upgrade
	
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
	$ClickSound.play()

func _on_add_passive_level_button_pressed():
	player_stats.passive_level_up()
	update()
	$ClickSound.play()
	pass # Replace with function body.


func _on_add_attack_level_button_pressed():
	player_stats.attack_level_up()
	update()
	$ClickSound.play()
	pass # Replace with function body.


func _on_add_skill_level_button_pressed():
	player_stats.skill_level_up()
	update()
	$ClickSound.play()
	pass # Replace with function body.
