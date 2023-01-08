extends Node2D

@export var cleave = preload("res://Enemy/AttackScenes/enemyCleave.tscn")
@export var cleave_stats: CleaveStats

@export var attack_frequency = 0.5

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
		var new_cleave = cleave.instantiate()
		new_cleave.set_damage(cleave_stats.damage)
		new_cleave.damage_callback = null
		modify_attack(new_cleave)
		
		var direction = (target_pos - global_position).normalized()
		var rot_angle = Vector2.LEFT.angle_to(direction.normalized())
		new_cleave.position = Vector2(-50, 0).rotated(rot_angle)
		new_cleave.rotation = rot_angle
		
		add_child(new_cleave)
		
		$AttackTimer.start()
	
func modify_attack(attack):
	pass

func get_target_position() :
	var players = get_tree().get_nodes_in_group("player").filter(func(x): return not x.is_dead and x.enabled)
	
	if len(players) == 0:
		return null
	
	var nearest_player = players[0]
	for player in players:
		if player.global_position.distance_to(global_position) < \
		player.global_position.distance_to(global_position):
			nearest_player = player
			
	return nearest_player.global_position
