extends Node2D

@export var projectile : ProjectileStats
@export var lifesteal_percentage : float = 100.0
@onready var dist_travelled = 0

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
		self.get_parent().get_parent().get_parent().modify_health(\
		projectile.damage * (lifesteal_percentage/100))
		
		queue_free()
	pass # Replace with function body.
