extends PlayerAttack

var cleave_attack = preload("res://Player/Abilities/cleave.tscn")

var max_amount = -1

var finished = false

var amount_active = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	print(global_position)
	print(duration / float(max_amount))
	pass # Replace with function body.

func set_damage(damage):
	self.damage = damage
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	if finished:
		if $Attacks.get_child_count() == 0:
			queue_free()
	else:
		if timer >  duration / float(max_amount):
			timer = 0
			
			spawn()
	pass

func spawn():
	if amount_active < max_amount:
		var new_cleave = cleave_attack.instantiate()
		
		new_cleave.set_damage(damage)
		new_cleave.damage_callback = damage_callback
		
		var reference_child = $Points.get_child(amount_active % $Points.get_child_count())
		new_cleave.position = reference_child.position
		new_cleave.rotation = reference_child.rotation
		
		$Attacks.add_child(new_cleave)
		
		amount_active += 1
	else:
		finished = true

