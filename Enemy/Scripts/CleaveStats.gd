extends Resource
class_name CleaveStats

@export var damage : float = 3.0
@export var range : float = 128.0
@export var size : float = 128.0
@export var texture : Texture2D

func _init(p_damage  : float = 3.0, p_range : float = 64.0, p_size : float = 64.0, p_texture  = null):
	damage = p_damage
	range = p_range
	size = p_size
	texture = p_texture
	pass
