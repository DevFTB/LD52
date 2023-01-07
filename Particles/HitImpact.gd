extends GPUParticles2D

@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func start_emitting():
	timer.wait_time = lifetime + 0.1
	timer.start()
	emitting = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_Timer_timeout() -> void:
	queue_free()
