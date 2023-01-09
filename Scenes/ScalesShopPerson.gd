extends AnimatedSprite2D

@export var min_blink_period : float 
@export var max_blink_period : float


@onready var target_period = min_blink_period
var timer = 0
func _ready():
	animation_finished.connect(on_animation_finished)
	pass

func _process(delta):
	timer += delta
	
	if timer > target_period:
		target_period = randf_range(min_blink_period, max_blink_period)
		timer = 0
		play("blink")
	

func on_animation_finished():
	if animation == "blink":
		play("default")
	pass	
