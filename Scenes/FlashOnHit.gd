extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_health_changed(new_health, difference, should_display):
	play("EnemyFlashOnHit")
	pass # Replace with function body.


func _on_character_health_changed(new_health):
	play("EnemyFlashOnHit")
	pass # Replace with function body.
