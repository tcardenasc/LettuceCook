extends Resource

class_name InventoryItem

@export var texture: Texture2D
@export var creatureName: String = ""
@export var description: String = ""
@export_enum("Creature", "Consumable", "Weapon")  
var type = "Creature"
@export var maxStackAmount: int = 1

func use():
	pass
		
		
