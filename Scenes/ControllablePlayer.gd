extends Node2D

@export var normal_attack : PackedScene 

@export var skill : PackedScene

@export var player_stats: PlayerStats

@onready var hp = player_stats.get_hp()
@onready var health = float(hp)

@onready var atk = player_stats.get_atk()
@onready var atk_speed = player_stats.get_atk_speed()
@onready var move_speed = player_stats.get_move_speed()


var dmg_reduction = 0

var direction : Vector2 = Vector2.ZERO
var facing  : Vector2 = Vector2.ZERO
signal stats_changed(hp, atk, atk_speed, move_speed, dmg_reduction, skill_cooldown)
signal health_changed(new_health, difference, should_display)
signal used_attack(cd)
signal used_skill(cd)
signal control_changed(controlled)
signal death
signal skill_used
signal attack_used


# Called when the node enters the scene tree for the first time.
var enabled = false
var can_use_skill = true
var is_dead = false
var controlled = false


var level_width = null

var buffs : Dictionary = {}

var nearest_enemy = null
var _find_enemy_timer = null
var find_enemy_timeout = 0.25

@export var ai_stopping_range = 20

func _ready():
	$AnimatedSprite.animation_finished.connect(on_anim_end)
	emit_signal("stats_changed", hp, atk, atk_speed, move_speed, dmg_reduction, player_stats.get_skill_cooldown())
	emit_signal("health_changed", health, 0, false)
	recalculate_stats()
	$AnimatedSprite.play("walk")
	
	# start find enemy timer
	_find_enemy_timer = Timer.new()
	add_child(_find_enemy_timer)
	_find_enemy_timer.timeout.connect(_find_enemy_timeout)
	_find_enemy_timer.set_wait_time(find_enemy_timeout)
	_find_enemy_timer.set_one_shot(false)
	_find_enemy_timer.start()
	pass # Replace with function body.
	
func get_nearest_enemy():
	var enemies = get_tree().get_nodes_in_group("enemy").filter(func (e): return not e.is_dead)
	
	if len(enemies) == 0:
		return null
	
	var nearest_enemy = enemies[0]
	for enemy in enemies:
		if enemy.global_position.distance_to(global_position) < \
		nearest_enemy.global_position.distance_to(global_position):
			nearest_enemy = enemy
	
	return nearest_enemy
	
func _find_enemy_timeout():
	nearest_enemy = get_nearest_enemy()
 
func _process(delta):
	if enabled and not is_dead and not controlled:
		process_ai(delta)
	elif enabled and not is_dead and controlled:
		var new_direction = Vector2.ZERO
		if Input.is_action_pressed("move_up"):
			new_direction += Vector2.UP
		if Input.is_action_pressed("move_down"):
			new_direction += Vector2.DOWN
		if Input.is_action_pressed("move_left"):
			new_direction += Vector2.LEFT
		if Input.is_action_pressed("move_right"):
			new_direction += Vector2.RIGHT
		
		if $AnimatedSprite.animation != "walk":
			do_walk()
		direction =  new_direction
		
		if new_direction.length() != 0:
			$AnimatedSprite.flip_h = direction.x < 0
			facing = direction

		
		
		position += direction.normalized() * move_speed * 100 * delta

func modify_health(modification):
	if not is_dead and enabled:
		if modification < 0:
			var delta =  modification * (1 - min(dmg_reduction, 1))
			health += delta
		else:
			health += modification
			
		health = min(hp, health)
		emit_signal("health_changed", health, modification, true)
		if health <= 0:
			die()


func die():
	emit_signal("death")
	is_dead = true 
	disable()

	$AnimatedSprite.play("walk")
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
	print(global_position)
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
	
func on_anim_end():
	if direction.x == 0 and direction.y == 0 :
		$AnimatedSprite.play("idle")

func do_walk():
	$AnimatedSprite.play("walk")

func do_attack():
	$AnimatedSprite.play("attack")
	var new_attack = normal_attack.instantiate()
	emit_signal("attack_used")
	new_attack.set_damage(get_attack_damage())
	new_attack.damage_callback = on_attack_damage
	new_attack.source_player = self
	
	modify_attack(new_attack)

	$Attack.add_child(new_attack)
	
	var rot_angle = Vector2.LEFT.angle_to(facing.normalized())
	new_attack.position = Vector2(-50, 0).rotated(rot_angle)
	new_attack.rotation = rot_angle
	emit_signal("used_attack", $AttackTimer.wait_time)

func do_skill():
	var new_skill = skill.instantiate()
	emit_signal("skill_used")

	new_skill.set_damage(get_attack_damage())
	new_skill.damage_callback = on_attack_damage
	new_skill.source_player = self
	new_skill.duration = player_stats.get_skill_duration()
	
	modify_skill(new_skill)
	
	var rot_angle = Vector2.LEFT.angle_to(facing.normalized())
	new_skill.position = Vector2(-50, 0).rotated(rot_angle)
	new_skill.rotation = rot_angle

	$Attack.add_child(new_skill)
	emit_signal("used_skill", $SkillTimer.wait_time)

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
	if controlled and not is_dead:
		if event is InputEventKey:
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

func walk_on(destination_x, duration):
	if not is_dead:
		do_walk()
		self.level_width = 1152
		var tween = get_tree().create_tween()
		var destination = Vector2(destination_x - 100, position.y)
		tween.tween_property(self, "global_position", destination, duration).from_current()


func apply_buff(buff: BuffStats, duration: float) -> void:
	var buff_id = Time.get_ticks_usec()
	buffs[buff_id] = buff
	var callback = func(): remove_buff(buff_id)
	get_tree().create_timer(duration).timeout.connect(callback)
	
	print("apply buff on " + name + " with id " +str(buff_id))
	recalculate_stats()
	
	var timer =  Timer.new()
	timer.wait_time = duration
	timer.autostart = true
	
	add_child(timer)
	pass

func remove_buff(key):
	print("removing buff from " + name  + " with id " + str(key))
	var buff = buffs[key]
	buffs.erase(key)
	
	recalculate_stats()

func enable_control():
	controlled = true
	direction = Vector2.ZERO
	emit_signal("control_changed", controlled)
	
func disable_control():
	controlled= false
	direction = Vector2.ZERO
	emit_signal("control_changed", controlled)

func recalculate_stats():
	var total = BuffStats.new()
	for buff in buffs:
		total = buffs[buff].stack_with(total)
		
	total.apply_to(self)
	
	$AttackTimer.wait_time = 1.0 / atk_speed
	$SkillTimer.wait_time = player_stats.get_skill_cooldown()
	emit_signal("stats_changed", hp, atk, atk_speed, move_speed, dmg_reduction, player_stats.get_skill_cooldown())
	
# ai stuff here
func process_ai(delta):
	if nearest_enemy:
		# todo: enforce player separation
		var enemy_pos = nearest_enemy.global_position

		direction.x = 0
		if enemy_pos.x > global_position.x + 64:
			direction.x = 1
		if enemy_pos.x < global_position.x - 64:
			direction.x = -1
		direction.y = 0

		if enemy_pos.y > global_position.y + 1:
			direction.y = 1
		if enemy_pos.y < global_position.y - 1:
			direction.y = -1
			
		if direction.length() > 0:
			$AnimatedSprite.play("walk")

		# todo: use range or make it smarter with skills
		if can_use_skill and not is_dead:
			do_skill()
			can_use_skill = false
			$SkillTimer.start()
		
		if global_position.distance_to(enemy_pos) > ai_stopping_range:
			position += direction.normalized() * move_speed * 100 * delta
