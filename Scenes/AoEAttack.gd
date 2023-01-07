extends Node2D

@export var duration = 0.4
@export var damage = 2

var timer = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if timer >= duration:
		queue_free()
	pass

func _on_area_2d_area_entered(area: Area2D):
	var enemy = area.get_parent()
	if enemy.is_in_group("enemy"):
		enemy.modify_health(-damage)
	pass # Replace with function body.
