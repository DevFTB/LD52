extends Resource
class_name CleaveStats

@export var damage : float = 3.0
@export var texture : Texture2D

func _init(p_damage  : float = 3.0, p_texture  = null):
	damage = p_damage
	texture = p_texture
	pass
