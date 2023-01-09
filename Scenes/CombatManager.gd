extends Node2D

@export var campaign : GameProgression 
@onready var current_zone = campaign.get_current_zone()
var current_round = -1
var arenas = []

signal on_arena_changed(round, zone)

func _ready():
	start_zone()

func start_zone():
	for i in range(current_zone.difficulty_levels.size()):
		var arena = spawn_arena(i)
		arenas.append(arena)
		$Arenas.add_child(arena)
		
	start_next_arena()

func spawn_arena(round):
	var zs = current_zone.zone_scenes
	var arena = zs[randi() % zs.size()]
	
	var instance = arena.instantiate()
	instance.difficulty_level = current_zone.difficulty_levels[round]
	instance.spawnable_groups = current_zone.enemies
	
	instance.position.x = -1152 * round
	
	instance.arena_finished.connect(func(): on_arena_finished(round))
	instance.arena_lost.connect(on_arena_lost)
	return instance

func switch_arena():
	var tween = get_tree().create_tween()
	var destination = $Arenas.position + Vector2(1152, 0)
	tween.tween_property($Arenas, "position", destination, 4)
	tween.tween_callback(start_next_arena)
	pass
	
func on_arena_lost():
	$AnimationPlayer.play("Fail")
	pass

func return_to_market():
	get_tree().change_scene_to_file("res://Scenes/item_shop.tscn")
	pass

func start_next_arena():
	current_round += 1
	if current_round >= arenas.size():
		campaign.current_zone_index += 1
		var tween = get_tree().create_tween()
		tween.tween_property($Arenas, "position", Vector2(0, 0), 5)
		tween.tween_callback(func(): $AnimationPlayer.play("Fail"))
		
	else:
		arenas[current_round].start_arena()
		emit_signal("on_arena_changed", current_round, current_zone)
	print(current_round)
	print("out of" + str(arenas.size()))
	pass

func on_arena_finished(round):
	switch_arena()
	pass
