extends Node2D

@export var damage = 20
@export var range = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func apply_damage(amount, range):
	var players = get_tree().get_nodes_in_group("player")\
	.filter(func(x): return not x.is_dead and x.enabled)\
	.filter(func(p): return p.global_position.distance_to(global_position) < range)
	
	
	for p in players:
		p.modify_health(-amount)
	


func _on_enemy_death():
	apply_damage(damage, range)
