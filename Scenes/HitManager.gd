extends Node2D

const BULLET_IMPACT = preload("res://Particles/HitImpact.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_health_changed(new_health, difference, should_display):
	if difference < 0:
		var impact = BULLET_IMPACT.instantiate()
		add_child(impact)
		impact.start_emitting()
			
	pass # Replace with function body.
			
		
