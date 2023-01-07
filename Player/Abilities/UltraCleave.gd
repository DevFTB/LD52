extends Node2D

@export var spawn_delay : float = 0.1

var cleave_attack = preload("res://Player/Abilities/cleave.tscn")
var amount_active = 0
@onready var max_amount = $Points.get_child_count()

var finished = false
var timer = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if finished:
		if $Attacks.get_child_count() == 0:
			queue_free()
	else:
		if timer > spawn_delay:
			timer = 0
			spawn()
	pass

func spawn():
	if amount_active < max_amount:
		print("inst")
		var new_cleave = cleave_attack.instantiate()
		
		var reference_child = $Points.get_child(amount_active)
		new_cleave.position = reference_child.position
		new_cleave.rotation = reference_child.rotation
		
		$Attacks.add_child(new_cleave)
		
		amount_active += 1
	else:
		finished = true

