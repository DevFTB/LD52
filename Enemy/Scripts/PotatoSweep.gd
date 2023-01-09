extends Node2D

@export var potato_sword = preload("res://Enemy/AttackScenes/potatoSword.tscn")

@export var attack_frequency = 0.5
@export var range = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	$AttackTimer.wait_time = 1.0 / attack_frequency

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func attack():
	var target_pos = get_target_position()
	
	if target_pos != null:
		var new_potato_sword = potato_sword.instantiate()
		var direction = (target_pos - global_position).normalized()

		new_potato_sword.rotation = direction.angle() + PI/2 - PI/3
		
		add_child(new_potato_sword)
		
	$AttackTimer.start()

func get_target_position() :
	var players = get_tree().get_nodes_in_group("player").filter(func(x): return not x.is_dead and x.enabled)
	# get in range players only
	players = players.filter(func(p): return p.global_position.distance_to(global_position) < range)
	
	
	if len(players) == 0:
		return null
	
	var nearest_player = players[0]
	for player in players:
		if player.global_position.distance_to(global_position) < \
		nearest_player.global_position.distance_to(global_position):
			nearest_player = player
			
	return nearest_player.global_position
