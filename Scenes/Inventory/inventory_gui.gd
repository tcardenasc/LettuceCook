extends Control

signal opened
signal closed
signal summon(itemName: String)

var isOpen: bool = true
var itemInHand: ItemStackGui
var itemInHandSize: Vector2

@onready var inventory: Inventory = preload("res://Scenes/Inventory/playerInventory.tres")
@onready var ItemStackGuiClass = preload("res://Scenes/Inventory/itemStackGui.tscn")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()


func _ready():
	connectSlots()
	inventory.updated.connect(update)
	update()
	
func connectSlots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventorySlot: InventorySlot = inventory.slots[i]
		if !inventorySlot.item: continue
		
		var itemStackGui: ItemStackGui = slots[i].itemStackGui
		if !itemStackGui: # si no hay, hay que crearla
			itemStackGui = ItemStackGuiClass.instantiate()
			slots[i].insert(itemStackGui)	
			
		itemStackGui.inventorySlot = inventorySlot
		itemStackGui.update()
		
	
func open():
	visible = true
	isOpen = true
	opened.emit()
	
func close():
	visible = false
	isOpen = false 
	closed.emit()

func onSlotClicked(slot):
	if slot.isEmpty():
		if !itemInHand: 
			return
		insertItemOnSlot(slot)
		return
		
	if !itemInHand:
		takeItemFromSlot(slot)
		return
	swapItems(slot)
func takeItemFromSlot(slot):
	itemInHand = slot.takeItem()
	itemInHandSize = itemInHand.size/2
	inventory.removeItemAtIndex(slot.index)
	add_child(itemInHand)
	updateItemInHand()
	

func insertItemOnSlot(slot):
	var item = itemInHand
	remove_child(itemInHand)
	itemInHand = null
	slot.insert(item)

func updateItemInHand():
	if !itemInHand: return
	itemInHand.global_position = get_global_mouse_position() - itemInHandSize
	
	
func _input(event):
	updateItemInHand()
	if event is InputEventKey and event.pressed:
		# Manejar la selección según el número presionado
		# KEY_1 - KEY_9 numeros consecutivos
		if (KEY_1 <= event.keycode and event.keycode <= KEY_9):
			useItemFrom(event.keycode % KEY_1)



func useItemFrom(slotNumber: int):
	if slots[slotNumber].isEmpty(): #si no hay nada en el slot...
		print("no item")
	else:
		var itemName = slots[slotNumber].itemStackGui.inventorySlot.item.creatureName
		#print("you tried to summon ",slots[slotNumber].itemStackGui.inventorySlot.item.creatureName) # si hay item en el slot...
		summon.emit(itemName)
		
func swapItems(slot):
	var tempItem = slot.takeItem()
	insertItemOnSlot(slot)
	itemInHand=tempItem
	add_child(itemInHand)
	updateItemInHand()
	
