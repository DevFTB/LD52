extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$HealthBar.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_health_changed(new_health, difference, should_display):
	if should_display:
		if difference < 0:
			$DamageNumber.start_animation(difference)
	
	var max_health = get_parent().max_hp
	if new_health == max_health:
		$HealthBar.visible = false
	else:
		$HealthBar.visible = true
		print("log", new_health, max_health)
		$HealthBar.value = round((new_health/max_health) * 100)
			
