extends Node2D

@export var projectile = preload("res://Enemy/projectile.tscn")
@export var projectile_stats: ProjectileStats

@export var attack_frequency = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	$AttackTimer.wait_time = 1.0 / attack_frequency
	print(projectile_stats)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func attack():
	var target_pos = get_target_position()
	
	var new_projectile = projectile.instantiate()
	var direction = (target_pos - global_position).normalized()
	print("Target pos: " + str(target_pos) + ", direction: " + str(direction)  + ", GLOBAL POS: " + str(global_position))
	new_projectile.set_details(direction, projectile_stats)
	
	add_child(new_projectile)
	
	$AttackTimer.start()
	pass

func get_target_position() -> Vector2:
	var player = get_tree().get_first_node_in_group("player")

	return player.global_position
	pass
