extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_2_health_changed(new_health, difference, should_display):
	if difference < 0 :
		$HealthBarShake.play("HealthBarShake")
		$HealthBarFlash.play("HealthBarFlash") 
