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
	
	if itemInHand.inventorySlot.item.creatureName == slot.itemStackGui.inventorySlot.item.creatureName:
		stackItems(slot)
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
	var slotUsed = slots[slotNumber]
	if slotUsed.isEmpty(): #si no hay nada en el slot...
		print("no item")
	else:
		var itemName = slotUsed.itemStackGui.inventorySlot.item.creatureName
		summon.emit(itemName)
		
func swapItems(slot):
	var tempItem = slot.takeItem()
	insertItemOnSlot(slot)
	itemInHand=tempItem
	add_child(itemInHand)
	updateItemInHand()
	
func stackItems(slot):
	var slotItem: ItemStackGui = slot.itemStackGui
	var maxAmount:int = slotItem.inventorySlot.item.maxStackAmount
	var totalAmount = slotItem.inventorySlot.amount + itemInHand.inventorySlot.amount
	
	if slotItem.inventorySlot.amount == maxAmount:
		swapItems(slot)
		return
		
	if totalAmount <= maxAmount:
		slotItem.inventorySlot.amount = totalAmount
		remove_child(itemInHand)
		itemInHand=null
		
	else:
		slotItem.inventorySlot.amount = maxAmount
		itemInHand.inventorySlot.amount = totalAmount - maxAmount
	
	slotItem.update()
	if itemInHand:
		itemInHand.update()
	
	
	
	
	
	
	
	
	
	
	
