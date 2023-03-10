extends Resource

class_name ItemBuffStats
@export var hp = 0.0
@export var atk = 0.0
@export var atk_speed = 0.0
@export var move_speed = 0.0
@export var dmg_reduction = 0.0
@export var skill_cooldown = 0.0
func stack_with(stats: ItemBuffStats) -> ItemBuffStats:
	return ItemBuffStats.new(hp + stats.hp, atk + stats.atk, atk_speed + stats.atk_speed, move_speed + stats.move_speed, dmg_reduction + stats.dmg_reduction)

func _init(p_hp = 0.0, p_atk = 0.0, p_atk_speed = 0.0, p_ms = 0.0, p_dr = 0.0, p_sc = 0.0):
	hp = p_hp
	atk = p_atk
	atk_speed = p_atk_speed
	move_speed = p_ms
	dmg_reduction = p_dr
	skill_cooldown = p_sc

func generate_description() -> String:
	var out = ""
	if hp != 0:
		out += "HP: " + str(hp) + "\n"
	if atk != 0:
		out += "ATK: " + str(atk)+ "\n"
	if atk_speed != 0:
		out += "ATK Speed: " + str(atk_speed)+ "\n"
	if move_speed != 0:
		out += "Move Speed: " + str(move_speed)+ "\n"
	if dmg_reduction != 0:
		out += "DMG Reduction: " + str(dmg_reduction)+"%"+ "\n"
	if skill_cooldown != 0:
		out += "Skill Cooldown Reduction: " + str(skill_cooldown)+"%"+ "\n"
	return out
