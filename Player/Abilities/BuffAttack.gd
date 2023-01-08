extends PlayerAttack

var buff_amount = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	buff()
	
	pass # Replace with function body.

func buff():
	var players = get_tree().get_nodes_in_group("player")
	
	for player in players:
		player.apply_buff(BuffStats.new(0, buff_amount, buff_amount, buff_amount), duration)
	pass
