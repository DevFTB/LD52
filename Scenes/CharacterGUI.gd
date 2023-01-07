extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_health_changed(new_health):
	$HealthBar.value = new_health
	pass # Replace with function body.


func _on_grim_cheaper_stats_changed(hp):
	$HealthBar.max_value = hp
	pass # Replace with function body.
