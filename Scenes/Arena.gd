extends Node2D

@export var spawnable_groups: Array[EnemyGroup]
@export var spawnable_area : Rect2
@export var level_size = Vector2(2304, 1408)
@export var difficulty_level :  int = 12
# Called when the node enters the scene tree for the first time.
func _ready():
	start_arena()

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_arena():
	$LevelStart.play("LevelStart")
	pass

func walk_on_players(duration):
	var players = get_tree().get_nodes_in_group("player")
	for player in players:
		player.walk_on(level_size.x, 100, duration)

func spawn_enemies():
	var enemy_groups = select_enemy_groups(difficulty_level)
	
	for eg in enemy_groups:
		var spawn_point = Vector2(randi() % roundi(spawnable_area.size.x), randi() % roundi(spawnable_area.size.y)) + spawnable_area.position
	
		var instance = eg.enemy_scene.instantiate()
		instance.position = spawn_point
		
		$Enemies.add_child(instance)
	pass
	
func enable_entities():
	var players = get_tree().get_nodes_in_group("player")
	for player in players:
		player.enable()
		
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.enable()
	pass

func select_enemy_groups(difficulty_level) -> Array[EnemyGroup]:
	var difficulties = spawnable_groups.map(func(g): return g.difficulty_level)
	
	var diff_total = 0
	
	var groups = []
	while diff_total < difficulty_level:
		var group_diff_limit = difficulty_level - diff_total
		var amount_lower_than_limit = difficulties.filter(func(d): return d <= group_diff_limit).size()
		
		if amount_lower_than_limit == 0:
			break
	
		var selection = randi() % amount_lower_than_limit
		
		var j = 0
		for i in range(difficulties.size()):
			if difficulties[i] <= group_diff_limit:
				if j == selection:
					groups.append(spawnable_groups[i])
					diff_total += difficulties[i]
				j+=1
	
	return groups
	
	