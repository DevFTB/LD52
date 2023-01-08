extends Node2D
class_name PlayerAttack

@export var duration = 0.4
@export var damage = 1

var timer = 0
var damage_callback = null

var source_player = null

func set_damage(damage):
	self.damage = damage
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if timer >= duration:
		do_final_action()
		queue_free()

func do_final_action():
	pass
