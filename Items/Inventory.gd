extends Resource
class_name Inventory

var items : Dictionary = {}

func add(item):
	if items.has(item):
		items[item] += 1
	else:
		items[item] = 1
	
func remove(item):
	if items.has(item):
		items[item] -= 1
		if items[item] == 0:
			items.erase(item)

func _init(p_i = {}):
	items = p_i

static func move(item: Item, from: Inventory, to: Inventory):
	from.remove(item)
	to.add(item)
	
func get_items():
	return items.keys
