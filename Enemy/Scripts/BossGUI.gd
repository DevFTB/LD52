extends Control

@export var health_bar : NodePath
@export var health_percentage : NodePath
@export var boss_name : NodePath


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node(boss_name).text = get_parent().enemy_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_health_changed(new_health, difference, should_display):
	if should_display:
		if difference < 0:
			$DamageNumber.start_animation(difference)

	var max_health = get_parent().max_hp
	get_node(health_bar).value = round((new_health/max_health) * 100)
	get_node(health_percentage).text = str(round((new_health/max_health) * 100)) + "%"


