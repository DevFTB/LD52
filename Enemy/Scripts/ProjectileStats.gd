extends Resource
class_name ProjectileStats

@export var damage : float = 2.0
@export var speed : float = 10.0
@export var range : float = 500.0
@export var texture : Texture2D
@export var mult_textures : AnimatedTexture

func _init(p_damage  : float = 2.0, p_speed: float  = 10.0 , p_range = 500.0, p_texture  = null, p_mult_textures = null):
	damage = p_damage
	speed = p_speed
	range = p_range
	texture = p_texture
	mult_textures = p_mult_textures
	pass
