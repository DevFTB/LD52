extends Node2D

@export var duration = 1
@onready var player = get_parent().get_parent()
var timer = 0
var buff_stats = BuffStats.new()

func _ready():
	player.add_buff(get_instance_id(), buff_stats)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if timer >= duration:
		queue_free()
	pass
