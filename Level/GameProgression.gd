extends Resource
class_name GameProgression
@export var zones : Array[Zone] = []
@export var items : Array[Item] = []
@export var stash : Inventory = Inventory.new()
@export var starting_money = 15

var current_zone_index = 0
var current_money = starting_money


func get_current_zone() -> Zone:
	return zones[current_zone_index]

func change_to_next_zone():
	current_zone_index += 1

	
func _init(p_z = [], p_i = [], p_s = Inventory.new()):
	zones = p_z
	items = p_i
	stash = p_s
	
