extends Node2D
var rng = RandomNumberGenerator.new()
var pitchRandom : float = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_arboarist_skill_used():
	$SkillSound.play()


func _on_arboarist_death():
	$DeathSound.play()


func _on_arboarist_attack_used():
	rng.randomize()
	pitchRandom = rng.randf_range(0.8,1.2)
	$AttackSound.play()
	$AttackSound.set_pitch_scale(pitchRandom)



func _on_arboarist_control_changed(controlled):
	if controlled == true :
		$ReadySound.play()
