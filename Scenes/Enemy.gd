extends Node2D

@export var enemy_name : String = "Enemy"
@export var max_hp : int = 20
@export var xp_on_death : int = 1

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
signal enable_changed(enabled)
signal death

var can_attack = []

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.visible = false
	emit_signal("health_changed", health, 0 , false)
	
	for child in range($Attacks.get_child_count()):
		can_attack.append(true)
		$Attacks.get_child(child).get_node("AttackTimer").timeout.connect(func(): enable_attack(child))
	
	$SpawnSprite.play("default")
	$SpawnSprite.frame_changed.connect(spawn_handler)
	$SpawnSprite.animation_finished.connect(func(): $SpawnSprite.visible = false)
	pass # Replace with function body.
	
func spawn_handler():
	if $SpawnSprite.frame == 2:
		$Sprite.visible = true
	pass
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
	var old_health = health
	if not is_dead:
		health = min(health + modification, max_hp)
		
		if health < 0:
			die()
			
		var difference = health - old_health
		if difference != 0:
			emit_signal("health_changed", health, difference, true)

func die():
	emit_signal("death")
	$Sprite.play("dead") 
	is_dead = true
	disable()
	
	pass

func enable():
	enabled = true
	emit_signal("enable_changed", enabled)
	pass
	
func disable():
	enabled = false
	emit_signal("enable_changed", enabled)
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
