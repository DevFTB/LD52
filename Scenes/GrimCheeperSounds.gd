extends Node2D

var rng = RandomNumberGenerator.new()
var hitRandom = 1 #random number for hit sound
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_grim_cheaper_skill_used():
	$SkillSound.play()



func _on_grim_cheaper_attack_used():
	rng.randomize()
	hitRandom = rng.randi_range(1,3)
	if hitRandom == 1 :
		$AttackSound.play()
	if hitRandom == 2 :
		$AttackSound2.play()
	if hitRandom == 3 :
		$AttackSound3.play()
