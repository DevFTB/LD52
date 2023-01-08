extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_the_sheepard_skill_used():
	$SkillSound.play()

func _on_the_sheepard_attack_used():
	$AttackSound.play()

func _on_the_sheepard_death():
	$DeathSound.play()
