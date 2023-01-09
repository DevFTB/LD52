extends "res://Enemy/Scripts/Projectile.gd"

@export var slow_amount : float = 0.7
@export var slow_time : float = 2.0
var slow_buff_name = "dirtydirtyslow"

func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("player"):
		print("projectile damage "  + str(projectile.damage))
		area.get_parent().modify_health(-projectile.damage)
		
		var hit_player = area.get_parent()
		var buffs = hit_player.buffs.values()
		if not buffs.any(func (b): return b.name == slow_buff_name):
			var new_buff = BuffStats.new(1, 1, 1, slow_amount, 0, 1.0, slow_buff_name)
			hit_player.apply_buff(new_buff, slow_time)
		
		
		queue_free()
	pass # Replace with function body.
