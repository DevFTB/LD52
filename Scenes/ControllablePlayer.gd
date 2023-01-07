extends Node2D

@export var movement_speed : float = 100

var direction : Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction.normalized() * movement_speed * delta
	pass

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("move_up"):
			direction.y -= 1
		if event.is_action_released("move_up"):
			direction.y += 1
			
		if event.is_action_pressed("move_down"):
			direction.y += 1
		if event.is_action_released("move_down"):
			direction.y -= 1
			
		if event.is_action_pressed("move_left"):
			direction.x -= 1
		if event.is_action_released("move_left"):
			direction.x += 1
			
		if event.is_action_pressed("move_right"):
			direction.x += 1
		if event.is_action_released("move_right"):
			direction.x -= 1
			
	pass
