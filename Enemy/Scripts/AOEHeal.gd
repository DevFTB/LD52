extends Node2D

@export var attack_frequency = 0.5
@export var heal_amount = 20
@export var heal_range = 200
var rng = RandomNumberGenerator.new()
var randomPitch : float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$AttackTimer.wait_time = 1.0 / attack_frequency
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func attack():
	heal(heal_amount, heal_range)
		
	$AttackTimer.start()

func heal(amount, range):
	var enemies = get_tree().get_nodes_in_group("enemy").\
	filter(func(e): return not e.is_dead and e.enabled).\
	filter(func(e): return e.global_position.distance_to(global_position) < range)
	
	rng.randomize()
	randomPitch = rng.randf_range(0.8,1.2)
	$HealSound.play()
	$HealSound.set_pitch_scale(randomPitch)
	
	
	for e in enemies:
		e.modify_health(amount)
	
