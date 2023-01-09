extends Node

@export var flash_duration: float = 0.2

@export var sprite : Node2D

func flash():
	sprite.use_parent_material = false
	get_tree().create_timer(flash_duration).timeout.connect(unflash)
	
func unflash():
	sprite.use_parent_material = true
	
func _on_health_changed(new_health, difference, should_display):
	if should_display:
		flash()
	pass
	

