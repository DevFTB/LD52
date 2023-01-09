extends Node2D

@export var rotate_speed = PI/4
@export var damage = 2
@onready var dist_travelled = 0

var rotate_distance = 2 * PI/3

@onready var hit_players = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dist_travelled < rotate_distance:
		rotation += rotate_speed * delta
		dist_travelled += rotate_speed * delta
	else:
		queue_free()



func _on_area_2d_area_entered(area):
	var hit = area.get_parent()
	if hit.is_in_group("player") and not hit in hit_players:
		hit_players[hit] = true
		hit.modify_health(-damage)
