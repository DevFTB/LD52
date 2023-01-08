extends Node2D

@export var duration = 0.4
@export var move = false

var damage = 0

var damage_callback 

var timer = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_damage(damage):
	self.damage = damage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if move:
		$Path2D/PathFollow2D.progress_ratio = timer / duration
	timer += delta
	if timer >= duration:
		queue_free()
	pass

func _on_area_2d_area_entered(area: Area2D):
	var enemy = area.get_parent()
	if enemy.is_in_group("enemy") and not enemy.is_dead:
		enemy.modify_health(-damage)
		if damage_callback != null:
			damage_callback.call(damage)
	pass # Replace with function body.
