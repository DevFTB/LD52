extends "res://Enemy/Scripts/ProjectileShoot.gd"

@export var num_projectiles = 5
@export var cone_angle = PI/3

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
		var direction = (target_pos - global_position).normalized().rotated(-cone_angle)
		
		for i in range(0, num_projectiles):
			var new_projectile = projectile.instantiate()
			new_projectile.set_details(direction, projectile_stats)
			
			add_child(new_projectile)
			
			direction = direction.rotated(2 * cone_angle / (num_projectiles - 1))
		
	$AttackTimer.start()
