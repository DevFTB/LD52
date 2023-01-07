extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_health_changed(new_health, difference, should_display):
	if should_display:
		if difference < 0:
			$DamageNumber.start_animation(difference)
			
