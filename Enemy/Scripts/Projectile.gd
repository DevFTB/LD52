extends Node2D

@export var projectile : ProjectileStats
@onready var dist_travelled = 0

var direction = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if projectile != null:
		if projectile.mult_textures:
			print("hi")
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			var mult_text = projectile.mult_textures
			$Sprite2D.texture = mult_text.get_frame_texture(randi_range(0, mult_text.frames - 1))
		else:
			$Sprite2D.texture = projectile.texture
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction != null and projectile != null:
		position += direction * projectile.speed * delta
		dist_travelled += (direction * projectile.speed * delta).length()
		if dist_travelled > projectile.range:
			queue_free()

func set_details(direction, projectile_stats):
	self.direction = direction
	projectile = projectile_stats

	rotation = direction.angle()


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("player"):
		print("projectile damage "  + str(projectile.damage))
		area.get_parent().modify_health(-projectile.damage)
		queue_free()
	pass # Replace with function body.
