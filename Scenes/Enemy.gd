extends Node2D

@export var enemy_name : String = "Enemy"
@export var max_hp : int = 20
@export var attack_range : float = 1
@export var base_attack : float = 1
@export var attack_frequency : float = 0.5

@onready var health = max_hp

signal health_changed(new_health, difference, should_display)
signal death

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("health_changed", health, 0 , false)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func modify_health(modification):
	health += modification
	
	if health < 0:
		die()
	emit_signal("health_changed", health, modification, true)

func die():
	print("death")
	emit_signal("death")
	pass


func _on_pain_timeout():
	modify_health(-1)
	pass # Replace with function body.
