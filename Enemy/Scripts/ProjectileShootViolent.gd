extends Node2D

@export var projectile = preload("res://Enemy/AttackScenes/projectile.tscn")
@export var projectile_stats: ProjectileStats

@export var attack_frequency = 0.5
@export var max_attack_frequency = 2

@onready var is_exhausted = false
@onready var is_super_mode = false
@onready var current_attack_freq =  attack_frequency

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
	
	is_exhausted = false
	
	if is_super_mode:
		$AttackTimer.wait_time = 1.0 / max_attack_frequency
	elif current_attack_freq >= max_attack_frequency:
		if $ExhaustedTimer.is_stopped():
			$ExhaustedTimer.set_wait_time(2)
			$ExhaustedTimer.set_one_shot(true)
			$ExhaustedTimer.start()
		$AttackTimer.wait_time = 1.0 / max_attack_frequency
	else:
		$AttackTimer.wait_time = 1.0 / current_attack_freq
		current_attack_freq += 0.2
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


func check_super_mode(new_health, difference, should_display):
	var max_hp = get_parent().get_parent().max_hp
	if new_health <= max_hp * (3.0/10):
		is_super_mode = true
		is_exhausted = false
		$AttackTimer.wait_time = 1.0 / max_attack_frequency
		$AttackTimer.start()
		
func exhaust():
	if not is_super_mode:
		is_exhausted = true
		$AttackTimer.wait_time = 5
		$AttackTimer.start()
		current_attack_freq = attack_frequency
