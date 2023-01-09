extends Control

@export var player_path : NodePath
@onready var player = get_node(player_path)

@export var player_icon : Texture2D
@export var player_border : Texture2D
@export var attack_icon : Texture2D
@export var skill_icon : Texture2D
@export var used_modulation = Color.hex(0x4d4d4d)
var attack_timer = 0
var skill_timer = 0

func _ready():
	$DeathRect.visible = false
	$Details/PlayerName.text = player.player_stats.get_player_name()
	
	$PlayerPortrait/PlayerIcon.texture = player_icon
	$PlayerPortrait/PlayerBorder.texture = player_border
	
	$Details/Abilities/Attack/AttackIcon.texture = attack_icon
	$Details/Abilities/Skill/SkillIcon.texture = skill_icon
	
	
	player.stats_changed.connect(_on_player_stats_changed)
	player.health_changed.connect(update_health)
	player.used_attack.connect(on_used_attack)
	player.used_skill.connect(on_used_skill)
	player.control_changed.connect(on_control_changed)
	player.death.connect(on_death)
	$Details/Abilities/Attack/AttackCDBar.visible = false
	$Details/Abilities/Skill/SkillCDBar.visible = false
	pass
	
func _process(delta):
	if attack_timer > 0:
		attack_timer -= delta
		if attack_timer <= 0:
			$Details/Abilities/Attack/AttackCDBar.visible = false
			$Details/Abilities/Attack/AttackIcon.modulate = Color.WHITE
		else:
			$Details/Abilities/Attack/AttackCDBar.value = attack_timer
	if skill_timer > 0:
		skill_timer -= delta
		if skill_timer <= 0:
			$Details/Abilities/Skill/SkillCDBar.visible = false
			$Details/Abilities/Skill/SkillIcon.modulate = Color.WHITE
		else:
			$Details/Abilities/Skill/SkillCDBar.value = skill_timer
	pass
func on_death():
	$DeathRect.visible = true
	
func on_control_changed(controlled):
	if controlled:
		$Details/PlayerName.modulate = Color.YELLOW_GREEN
	else:
		$Details/PlayerName.modulate = Color.WHITE
	pass
	
func _on_player_stats_changed(hp, atk, atk_speed, move_speed, dmg_reduction, skill_cooldown):
	update_hp(hp)
	update_atk_speed(atk_speed)
	update_skill_cooldown(skill_cooldown)
	pass

func on_used_attack(cd):
	$Details/Abilities/Attack/AttackCDBar.max_value = cd
	attack_timer = cd
	
	$Details/Abilities/Attack/AttackCDBar.visible = true
	$Details/Abilities/Attack/AttackCDBar.value = cd
	$Details/Abilities/Attack/AttackIcon.modulate = used_modulation
	pass
	
func on_used_skill(cd):
	update_skill_cooldown(cd)
	skill_timer = cd
	
	$Details/Abilities/Skill/SkillCDBar.visible = true
	$Details/Abilities/Skill/SkillIcon.modulate = used_modulation
	$Details/Abilities/Skill/SkillCDBar.value = cd
	pass
func update_health(new_health, difference, should_display):
	$Details/HealthBar.value = new_health

func update_hp(hp):
	$Details/HealthBar.max_value = hp

func update_atk_speed(atk_speed):
	$Details/Abilities/Attack/AttackCDBar.max_value = 1.0 / atk_speed
	
func update_skill_cooldown(skill_cooldown):
	$Details/Abilities/Skill/SkillCDBar.max_value = skill_cooldown
