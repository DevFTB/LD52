extends Node2D

@export var normal_attack : PackedScene 

@export var skill : PackedScene

@export var player_stats: PlayerStats

@onready var hp = player_stats.get_hp()
@onready var health = hp

@onready var atk = player_stats.get_atk()
@onready var atk_speed = player_stats.get_atk_speed()
@onready var move_speed = player_stats.get_move_speed()

var direction : Vector2 = Vector2.ZERO

signal stats_changed(hp, atk, atk_speed, move_speed)
signal health_changed(new_health, difference, should_display)
signal death
signal skill_used
signal attack_used

# Called when the node enters the scene tree for the first time.

var enabled = false
var can_use_skill = true
var is_dead = false
var controlled = true

var level_width = null

var buffs : Dictionary = {}

func _ready():
	emit_signal("stats_changed", hp, atk, atk_speed, move_speed)
	emit_signal("health_changed", health, 0, false)
	recalculate_stats()
	pass # Replace with function body.
 
func _process(delta):
	if enabled and not is_dead:
		position += direction.normalized() * move_speed * 100 * delta
		pass

func modify_health(modification):
	if not is_dead and enabled:
		health += modification
		health = min(hp, health)
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
		var duration = ((level_width + 150) - position.x) / (move_speed * 150)
		tween.tween_property(self, "position", destination, duration).from_current()
	pass
	
func enable():
	enabled = true
	can_use_skill = true
	
	$AttackTimer.start()
	$SkillTimer.start()
	pass
	
func disable():
	enabled = false
	$AttackTimer.stop()
	$SkillTimer.stop()
	
	# relinquish user control
	pass

func get_attack_damage():
	return player_stats.get_attack_damage(atk)
	
func get_skill_damage():
	return player_stats.get_skill_damage(atk)

func do_attack():
	var new_attack = normal_attack.instantiate()
	emit_signal("attack_used")
	
	new_attack.set_damage(get_attack_damage())
	new_attack.damage_callback = on_attack_damage
	
	modify_attack(new_attack)

	$Attack.add_child(new_attack)
	
	var rot_angle = Vector2.LEFT.angle_to(direction.normalized())
	new_attack.position = Vector2(-50, 0).rotated(rot_angle)
	new_attack.rotation = rot_angle

func do_skill():
	var new_skill = skill.instantiate()
	emit_signal("skill_used")

	new_skill.set_damage(get_attack_damage())
	new_skill.damage_callback = on_attack_damage
	
	modify_skill(new_skill)
	
	var rot_angle = Vector2.LEFT.angle_to(direction.normalized())
	new_skill.position = Vector2(-50, 0).rotated(rot_angle)
	new_skill.rotation = rot_angle

	$Attack.add_child(new_skill)
func modify_attack(attack):
	pass

func modify_skill(skill):
	skill.duration = player_stats.get_skill_duration()
	pass

func do_combat(attack, damage):
	var new_attack = attack.instantiate()
	$Attack.add_child(new_attack)
	
	new_attack.set_damage(get_attack_damage())
	new_attack.damage_callback = on_attack_damage
	
	var rot_angle = Vector2.LEFT.angle_to(direction.normalized())
	new_attack.position = Vector2(-50, 0).rotated(rot_angle)
	new_attack.rotation = rot_angle
	
func on_attack_damage(damage):
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
			
			if event.is_action_pressed("skill"):
				if can_use_skill and not is_dead:
					do_skill()
					can_use_skill = false
					$SkillTimer.start()
	pass

func _on_attack_timer_timeout():
	do_attack()
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
	
func apply_buff(buff: BuffStats, duration: float) -> void:
	var time = Time.get_ticks_msec()
	buffs[time] = buff
	
	recalculate_stats()
	
	get_tree().create_timer(duration).timeout.connect(func(): remove_buff(time))
	pass

func remove_buff(time_key):
	var buff = buffs[time_key]
	buffs.erase(time_key)
	
	recalculate_stats()

func recalculate_stats():
	var total = BuffStats.new()
	for buff in buffs:
		total = buffs[buff].stack_with(total)
		
	total.apply_to(self)
	
	$AttackTimer.wait_time = 1.0 / atk_speed
	$SkillTimer.wait_time = player_stats.get_skill_cooldown()
