extends Node

@export var flash_duration: float = 0.2

@onready var parent_sprite =get_parent().get_sprite()

func flash():
	parent_sprite.use_parent_material = false
	get_tree().create_timer(flash_duration).timeout.connect(unflash)
	
func unflash():
	parent_sprite.use_parent_material = true
	
func _on_health_changed(new_health, difference, should_display):
	if should_display:
		flash()
	pass
