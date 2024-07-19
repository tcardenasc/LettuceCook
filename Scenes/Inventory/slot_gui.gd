extends Button

@onready var backgroundSprite: Sprite2D = $background
@onready var container: CenterContainer =$CenterContainer
@onready var inventory: Inventory = preload("res://Scenes/Inventory/playerInventory.tres")
var itemStackGui: ItemStackGui
var index: int
func insert(isg: ItemStackGui):
	itemStackGui = isg
	container.add_child(itemStackGui)
	
	if !itemStackGui.inventorySlot || inventory.slots[index]==itemStackGui.inventorySlot:
		return
	inventory.insertSlot(index, itemStackGui.inventorySlot)
		
func takeItem():
	var item = itemStackGui
	inventory.removeSlot(itemStackGui.inventorySlot)
	#container.remove_child(itemStackGui)
	#itemStackGui=null
	return item
func clear():
	if itemStackGui:
		container.remove_child(itemStackGui)
		itemStackGui=null
	
func isEmpty():
	return !itemStackGui


