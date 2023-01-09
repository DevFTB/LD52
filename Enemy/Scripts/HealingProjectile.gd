extends "res://Enemy/Scripts/Projectile.gd"

@export var lifesteal_percentage : float = 100.0


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("player"):
		print("projectile damage "  + str(projectile.damage))
		area.get_parent().modify_health(-projectile.damage)
		self.get_parent().get_parent().get_parent().modify_health(\
		projectile.damage * (lifesteal_percentage/100))
		
		queue_free()
	pass # Replace with function body.
