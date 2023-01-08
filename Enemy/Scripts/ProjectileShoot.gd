extends Node2D

@export var projectile = preload("res://Enemy/AttackScenes/projectile.tscn")
@export var projectile_stats: ProjectileStats

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
		var new_projectile = projectile.instantiate()
		var direction = (target_pos - global_position).normalized()

		new_projectile.set_details(direction, projectile_stats)
		
		add_child(new_projectile)
		
	$AttackTimer.start()

func get_target_position() :
	var players = get_tree().get_nodes_in_group("player").filter(func(x): return not x.is_dead and x.enabled)
	# get in range players only
	players = players.filter(func(p): return p.global_position.distance_to(global_position) < projectile_stats.range)
	
	if players.size() > 0:
		var selected = players[randi() % players.size()]
		return selected.global_position
	else:
		return null
	pass
