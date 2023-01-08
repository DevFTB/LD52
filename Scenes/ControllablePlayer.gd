extends Node2D

@export var movement_speed : float = 100
@export var starting_hp : float = 10

# the variable hp stat, max health
@onready var hp = starting_hp 

# the health of the character
@onready var health = hp

var direction : Vector2 = Vector2.ZERO



signal stats_changed(hp)
signal health_changed(new_health, difference, should_display)
signal death

var normal_attack = preload("res://Player/Abilities/cleave.tscn")
var skill = preload("res://Player/Abilities/ultra_cleave.tscn")
# Called when the node enters the scene tree for the first time.

var enabled = false
var can_use_skill = true
var is_dead = false

var controlled = true

var level_width = null

func _ready():
	emit_signal("stats_changed", hp)
	emit_signal("health_changed", health, 0, false)
	print("player pos: " + str(global_position))
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enabled and not is_dead:
		position += direction.normalized() * movement_speed * delta
		pass

func modify_health(modification):
	if not is_dead and enabled:
		health += modification
		if health < 0:
			die()
		emit_signal("health_changed", health, modification, true)

func die():
	emit_signal("death")
	is_dead = true 
	disable()

	if level_width != null:
		var tween = get_tree().create_tween()
		var destination = Vector2(level_width + 150, position.y + (randi() % 150))
		var duration = ((level_width + 150) - position.x) / (movement_speed * 1.5)
		tween.tween_property(self, "position", destination, duration).from_current()
	pass


	
func enable():
	enabled = true
	can_use_skill = true
	$AttackTimer.start()
	pass
	
func disable():
	enabled = false
	$AttackTimer.stop()
	$SkillTimer.stop()
	
	# relinquish user control
	pass

func do_attack(attack):
	var new_attack = attack.instantiate()
	$Attack.add_child(new_attack)
	
	var rot_angle = Vector2.LEFT.angle_to(direction.normalized())
	print(rot_angle)
	new_attack.position = Vector2(-50, 0).rotated(rot_angle)
	new_attack.rotation = rot_angle
	pass
	
func _input(event):
	if controlled:
		if event is InputEventKey:
			if event.is_action_pressed("move_up"):
				direction.y -= 1
			if event.is_action_released("move_up"):
				direction.y += 1
				
			if event.is_action_pressed("move_down"):
				direction.y += 1
			if event.is_action_released("move_down"):
				direction.y -= 1
				
			if event.is_action_pressed("move_left"):
				direction.x -= 1
			if event.is_action_released("move_left"):
				direction.x += 1
				
			if event.is_action_pressed("move_right"):
				direction.x += 1
			if event.is_action_released("move_right"):
				direction.x -= 1
			
			if event.is_action_pressed("skill") and can_use_skill and not is_dead:
				do_attack(skill)
				can_use_skill = false
				$SkillTimer.start()
	pass


func _on_attack_timer_timeout():
	
	do_attack(normal_attack)
	pass # Replace with function body.


func _on_skill_timer_timeout():
	can_use_skill = true
	pass # Replace with function body.

func get_sprite():
	return $Sprite

func walk_on(level_width, edge_offset, duration):
	self.level_width = level_width
	var tween = get_tree().create_tween()
	var destination = Vector2(level_width - edge_offset, position.y)
	tween.tween_property(self, "position", destination, duration).from_current()
	
