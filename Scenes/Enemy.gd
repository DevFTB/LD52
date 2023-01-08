extends Node2D

@export var enemy_name : String = "Enemy"
@export var max_hp : int = 20
#@export var attack_range : float = 1
#@export var player_attack : float = 1
#@export var is_melee : bool = false

#sound files export vars below

@export var hitSound : AudioStreamPlayer2D
@export var deathSound : AudioStreamPlayer2D

@onready var health = max_hp

var is_dead = false
var enabled = false

signal health_changed(new_health, difference, should_display)
signal death

var can_attack = []

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("health_changed", health, 0 , false)
	
	for child in range($Attacks.get_child_count()):
		can_attack.append(true)
		$Attacks.get_child(child).get_node("AttackTimer").timeout.connect(func(): enable_attack(child))
	

	pass # Replace with function body.
func enable_attack(index):
	can_attack[index] = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_dead and enabled:
		var available_attack = can_attack.find(true)
		if available_attack != -1:
			attack(available_attack)
		pass

func modify_health(modification):
	if not is_dead:
		health = min(health + modification, max_hp)
		
		if health < 0:
			die()
		emit_signal("health_changed", health, modification, true)

func die():
	print("death")
	emit_signal("death")
	$Sprite.play("dead")    
	is_dead = true
	pass

func enable():
	enabled = true
	pass
	
func disable():
	enabled = false
	pass

func _on_pain_timeout():
	modify_health(-1)
	pass # Replace with function body.
	
func get_sprite():
	return $Sprite

func attack(available_attack):
	# Can be changed for more complexity
	$Attacks.get_child(available_attack).attack()
	can_attack[available_attack] = false


func _on_health_changed(new_health, difference, should_display):
	pass # Replace with function body.
