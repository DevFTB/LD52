extends Label

@export var offset = Vector2(0, -40)
@export var animation_duration : float  = 1.0

@onready var starting_position = position
@onready var destination = offset + position
# Called when the node enters the scene tree for the first time.

var current_tween = null
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_animation(new_value):
	if current_tween != null:
		print('killing')
		current_tween.kill()
		on_animation_end()
	
	text = str(new_value)
	current_tween = get_tree().create_tween()

	
	print(starting_position)
	print(destination)

	current_tween.set_parallel(true)
	current_tween.tween_property(self, "position", destination, animation_duration).from(starting_position)
	current_tween.tween_property(self, "modulate", Color(Color.WHITE, 0), animation_duration).from(Color(Color.WHITE, 1))
	current_tween.tween_callback(self.on_animation_end)

func on_animation_end():
	print("ended")
	current_tween = null

