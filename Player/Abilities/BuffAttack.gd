extends Node2D

@export var player_duration = 4.9
@export var damage = 2

var buff_amount = 0
var duration = 0

var timer = 0

var damage_callback = null
# Called when the node enters the scene tree for the first time.
func _ready():
	buff_allies()
	pass # Replace with function body.

func buff_allies():
	var players = get_tree().get_nodes_in_group("player")
	
	for player in players:
		player.apply_buff(BuffStats.new(0, buff_amount, buff_amount, buff_amount), duration)
	pass

func set_damage(dmg):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if timer >= duration:
		queue_free()
	pass # Replace with function body.
