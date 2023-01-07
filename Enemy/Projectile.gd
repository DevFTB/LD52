extends Node2D

@export var projectile : ProjectileStats

var direction = null
# Called when the node enters the scene tree for the first time.
func _ready():
	if projectile != null:
		$Sprite2D.texture = projectile.texture
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction != null and projectile != null:
		position += direction * projectile.speed * delta
	pass

func set_details(direction, projectile_stats):
	self.direction = direction
	projectile = projectile_stats
	#$print(str(global_position) + ", " + str(position))
	print(direction)
	rotation = direction.angle()


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("player"):
		area.get_parent().modify_health(-projectile.damage)
		queue_free()
	pass # Replace with function body.