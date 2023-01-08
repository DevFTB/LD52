extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_arboarist_skill_used():
	$SkillSound.play()


func _on_arboarist_death():
	$DeathSound.play()


func _on_arboarist_attack_used():
	$AttackSound.play()



func _on_arboarist_control_changed(controlled):
	if controlled == true :
		$ReadySound.play()
