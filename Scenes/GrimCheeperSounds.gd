extends Node2D
var rng = RandomNumberGenerator.new()
var hitRandom = 1


func _on_grim_cheaper_attack_used():
	rng.randomize()
	hitRandom = rng.randi_range(1,3)
	if hitRandom == 1 :
		$"AttackSound".play()
	if hitRandom == 2 :
		$"AttackSound2".play()
	if hitRandom == 3 :
		$"AttackSound3".play()


func _on_grim_cheaper_death():
	$DeathSound.play()

func _on_grim_cheaper_skill_used():
	$SkillSound.play()


func _on_grim_cheaper_control_changed(controlled):
	if controlled == true :
		$ReadySound.play() # Replace with function body.
