extends Resource
class_name PlayerStats

@export var player_name = "Player"
@export var player_portrait : Texture2D
var level = 1
var unused_skill_points = 0
var xp = 0

@export var hp : Stat = null
@export var atk : Stat = null
@export var atk_speed : Stat = null
@export var move_speed : Stat = null

@export var attack_scaling : Stat = null
var attack_level = 1

@export var skill_scaling : Stat = null
@export var skill_cooldown : Stat = null
@export var skill_duration : Stat = null
var skill_level = 1

var passive_level = 1
@export var passive : Stat = null

@export var inventory = Inventory.new()

@export var inventory_size : Stat = null
func get_inventory_size():
	return inventory_size.get_effective_value(level)
func add_item(item):
	if can_add_to_inventory():
		inventory.add(item)
		recalculate_item_bonuses()
		
	pass

func remove_item(item):
	inventory.remove(item)
	recalculate_item_bonuses()
	pass

func attack_level_up():
	if unused_skill_points > 0:
		unused_skill_points -= 1
		attack_level += 1
	pass
	
func skill_level_up():
	if unused_skill_points > 0:
		unused_skill_points -= 1
		skill_level += 1
	pass
func passive_level_up():
	if unused_skill_points > 0:
		unused_skill_points -= 1
		passive_level += 1
	pass
func can_add_to_inventory():
	return inventory.get_amount_stored() < inventory_size.get_effective_value(get_level())
	pass

func recalculate_item_bonuses():
	var total = ItemBuffStats.new()
	
	for item in inventory.items:
		var amount = inventory.items[item]
		for i in range(amount):
			total = total.stack_with(item.stats)
	
	hp.apply_item_modifier(total.hp) 
	atk.apply_item_modifier(total.atk)
	atk_speed.apply_item_modifier(total.atk_speed)
	skill_cooldown.apply_item_modifier(total.skill_cooldown)
	move_speed.apply_item_modifier(total.move_speed)
	
	pass

@export var level_log_base = 1.5
func get_level() -> int:
	return floor((16 + xp) / 28 + 1)

func gain_xp(xp):
	var current_level = get_level()
	self.xp += xp
	var new_level =get_level()
	
	if new_level > current_level:
		unused_skill_points += new_level - current_level
	
func get_player_name():
	return player_name

func get_hp(multiplier = 1):
	return hp.get_effective_value(get_level(), multiplier)
	
func get_atk(multiplier = 1):
	return atk.get_effective_value(get_level(), multiplier)

func get_atk_speed(multiplier = 1):
	return atk_speed.get_effective_value(get_level(), multiplier)

func get_move_speed(multiplier = 1):
	return move_speed.get_effective_value(get_level(), multiplier)
	
func get_attack_scaling(multiplier= 1):
	return attack_scaling.get_effective_value(attack_level)
	
func get_skill_cooldown(multiplier = 1):
	return skill_cooldown.get_effective_value(skill_level)
	
func get_skill_scaling(multiplier = 1):
	return skill_scaling.get_effective_value(skill_level)
	
func get_passive(multiplier = 1):
	return passive.get_effective_value(skill_level)

func get_skill_duration(multiplier = 1):
	return skill_duration.get_effective_value(skill_level)
	
func get_attack_damage(atk):
	return atk * get_attack_scaling()

func get_skill_damage(atk):
	return atk * get_skill_scaling()
	
func _init(p_hp = null, p_a = null, p_as = null, p_ms = null, p_nas = null, p_ss = null, p_sc = null, p_sd = null, p_p = null, p_i = null):
	hp = p_hp
	atk = p_a
	atk_speed = p_as
	move_speed = p_ms
	attack_scaling = p_nas
	skill_scaling = p_ss
	skill_duration = p_sd
	skill_cooldown = p_sc
	passive = p_p
	inventory = p_i
	
