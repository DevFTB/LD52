extends Resource
class_name EnemyGroup

@export var enemy_scene : PackedScene
@export var number_of_enemies : int
@export var difficulty_level : int

func _init(p_enemy_scene = null, p_number_of_enemies = 0, p_difficulty_level = 0):
	enemy_scene = p_enemy_scene
	number_of_enemies = p_number_of_enemies
	difficulty_level = p_difficulty_level

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
