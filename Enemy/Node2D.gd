extends Node2D

var rng = RandomNumberGenerator.new()
var hitRandom = 1 #random number for hit sound
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_enemy_health_changed(new_health, difference, should_display):
	if difference < 0 :
		rng.randomize()
		hitRandom = rng.randi_range(1,3)
		if hitRandom == 1 :
			$"Hit Sound".play()
		if hitRandom == 2 :
			$"Hit Sound2".play()
		if hitRandom == 3 :
			$"Hit Sound3".play()
		

