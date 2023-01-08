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
			$"HitSound".play()
		if hitRandom == 2 :
			$"HitSound2".play()
		if hitRandom == 3 :
			$"HitSound3".play()
		



func _on_enemy_death():
	rng.randomize()
	deathRandom = rng.randi_range(1,9)
	if deathRandom == 1 :
		$"DeathSound".play()
	if deathRandom == 2 :
		$"DeathSound2".play()
	if deathRandom == 3 :
		$"DeathSound3".play()
	if deathRandom == 4 :
		$"DeathSound4".play()
	if deathRandom == 5 :
		$"DeathSound5".play()
	if deathRandom == 6 :
		$"DeathSound6".play()
	if deathRandom == 7 :
		$"DeathSound7".play()
	if deathRandom == 8 :
		$"DeathSound8".play()
	if deathRandom == 9 :
		$"DeathSound9".play()

