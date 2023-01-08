extends Node2D
var rng = RandomNumberGenerator.new()
var pitchRandom : float = 1


	

func _on_the_sheepard_skill_used():
	$SkillSound.play()

func _on_the_sheepard_attack_used():
	rng.randomize()
	pitchRandom = rng.randf_range(0.5,1.5)
	$AttackSound.play()
	$AttackSound.set_pitch_scale(pitchRandom)
	
func _on_the_sheepard_death():
	$DeathSound.play()

func _on_the_sheepard_control_changed(controlled):
	if controlled == true :
		$ReadySound.play()
