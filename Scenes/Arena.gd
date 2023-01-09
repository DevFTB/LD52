extends Node2D

@export var spawnable_groups: Array[EnemyGroup]
@export var spawnable_area : Rect2
@export var level_size = Vector2(2304, 1408)
@export var difficulty_level :  int = 12

@onready var players  = get_tree().get_nodes_in_group("player")

var combat_instance

var enemies = []
var xp_gained = 0

var amount_of_dead_enemies = 0

var controlled_player_index = 0

signal arena_finished
signal arena_lost

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_arena():
	for player in players:
		player.death.connect(func(): on_player_death(player))
		
	$LevelStart.play("LevelStart")
	
	players[controlled_player_index].enable_control()
	pass

func end_arena():
	var total_xp = enemies.reduce(func(accum,en): return accum + en.xp_on_death, 0)
	for player in players:
		player.player_stats.gain_xp(total_xp)
		player.disable_control()
		
		
	emit_signal("arena_finished")
		
	# move to next arena
	
func walk_on_players(duration):
	var players = get_tree().get_nodes_in_group("player")
	for player in players:
		player.walk_on(global_position.x + level_size.x, duration)

func spawn_enemies():
	var enemy_groups = select_enemy_groups(difficulty_level)
	
	for eg in enemy_groups:
		var spawn_point = Vector2(randi() % roundi(spawnable_area.size.x), randi() % roundi(spawnable_area.size.y)) + spawnable_area.position
	
		var instance = eg.enemy_scene.instantiate()
		instance.position = spawn_point
		
		enemies.append_array(instance.get_children())
		
		for en in instance.get_children():
			en.death.connect(func(): on_enemy_death(en))
		
		$Enemies.add_child(instance)
	pass
	
func enable_entities():
	for player in players:
		player.enable()
		
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.enable()
	pass

func select_enemy_groups(difficulty_level) -> Array[EnemyGroup]:
	var diff_total = 0
	
	var groups = []
	while diff_total < difficulty_level:
		var group_diff_limit = difficulty_level - diff_total
		var valid_spawnable_groups = spawnable_groups.filter(func(g) : return g.difficulty_level <= group_diff_limit)
		var amount_lower_than_limit = len(valid_spawnable_groups)
		
		if amount_lower_than_limit == 0:
			break
	
		var selection = randi() % amount_lower_than_limit
		
		groups.append(valid_spawnable_groups[selection])
		diff_total += valid_spawnable_groups[selection].difficulty_level
	
	return groups

func on_player_death(player):
	if player.controlled:
		player.disable_control()
		
		controlled_player_index = -1
		for p in players:
			if not p.is_dead and p != player:
				p.enable_control()
				print(p.name)
				controlled_player_index = players.find(p)
				break
		
		if controlled_player_index == -1:
			lose_round()	
	pass
func lose_round():
	emit_signal("arena_lost")
	pass
	
func _input(event):
	if event is InputEventKey:
		if event.is_action_released("switch_player"):
			var valid_players = players.filter(func(p): return not p.is_dead and p.enabled)
			
			if valid_players.size() == 0:
				controlled_player_index = -1
				return
			
			players[controlled_player_index].disable_control()
			controlled_player_index = (controlled_player_index + 1) % valid_players.size()
			var new_player = valid_players[controlled_player_index]
			new_player.enable_control()
			controlled_player_index = players.find(new_player)
			
			print(new_player.name)
			

func on_enemy_death(enemy):
	amount_of_dead_enemies += 1
	
	combat_instance.gain_rewards(enemy)
	
	if amount_of_dead_enemies == enemies.size():
		end_arena()
	pass

func _on_grim_cheaper_control_changed(controlled):
	pass # Replace with function body.
