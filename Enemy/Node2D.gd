extends Node2D

var rng = RandomNumberGenerator.new()
var hitRandom = 1
var deathRandom = 1 #random number for hit sound
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
		



func _on_enemy_death():
	rng.randomize()
	deathRandom = rng.randi_range(1,9)
	print(deathRandom)
	if deathRandom == 1 :
		$"Death Sound".play()
	if deathRandom == 2 :
		$"Death Sound2".play()
	if deathRandom == 3 :
		$"Death Sound3".play()
	if deathRandom == 4 :
		$"Death Sound4".play()
	if deathRandom == 5 :
		$"Death Sound5".play()
	if deathRandom == 6 :
		$"Death Sound6".play()
	if deathRandom == 7 :
		$"Death Sound7".play()
	if deathRandom == 8 :
		$"Death Sound8".play()
	if deathRandom == 9 :
		$"Death Sound9".play()

