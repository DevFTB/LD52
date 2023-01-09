extends Resource
class_name Item

enum Rarity {
	COMMON, RARE, EPIC, LEGENDARY, MYTHIC
}

@export var item_name : String 
@export var icon : Texture2D = null
@export var rarity : Rarity
@export var stats : ItemBuffStats
@export var cost : int

