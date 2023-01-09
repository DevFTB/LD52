extends Node2D

@export var damage = 20
@export var range = 300
@export var deathDelay :float = 2 #explosion delay

var _death_timer = 5

# Called when the node enters the scene tree for the first time.
func _on_enemy_death():
	_death_timer = Timer.new()
	add_child(_death_timer)
	_death_timer.timeout.connect(do_death)
	_death_timer.set_wait_time(deathDelay)
	_death_timer.set_one_shot(true)
	_death_timer.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func apply_damage(amount, range):
	var players = get_tree().get_nodes_in_group("player")\
	.filter(func(x): return not x.is_dead and x.enabled)\
	.filter(func(p): return p.global_position.distance_to(global_position) < range)
	
	
	for p in players:
		p.modify_health(-amount)
	


func do_death():
	print("death explosion")
	apply_damage(damage, range)
