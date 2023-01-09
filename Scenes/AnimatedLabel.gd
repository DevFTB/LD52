extends Label

@export var animation_duration : float = 2.0
var target_string = ""
var progress : float = 0.0

var animating = false
var timer : float = 0.0

func display_text(str: String):
	target_string = str
	animating = true
	progress = 0.0
	timer = 0
	
	pass

func _process(delta):
	if animating:
		timer += delta
		progress = timer / animation_duration
		display_progress(progress)
		
		if timer > animation_duration:
			animating = false
			text = target_string
		

	pass

func display_progress(progress):
	print(len(target_string))
	var substring = target_string.substr(0, floor(len(target_string) * progress))
	text = substring
