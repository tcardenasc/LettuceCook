extends Resource

class_name Inventory

@export var slots: Array[InventorySlot]

signal updated

func insert(item: InventoryItem):
	#primero filtra, consiguiendo los slots que sean del mismo item y que no esten llenos
	var itemSlots=slots.filter(func(slot): return slot.item==item && slot.amount < item.maxStackAmount)
	if !itemSlots.is_empty():
		itemSlots[0].amount += 1
	else:
		#consigue los slots vacios
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
		else:
			print("no hay espacio en el inventario D:")
	updated.emit()

func removeSlot(inventorySlot: InventorySlot):
	var index = slots.find(inventorySlot)
	if index < 0: return
	removeAtIndex(index)
	
func removeAtIndex(index: int)->void:
	slots[index] = InventorySlot.new()
	updated.emit()

func useItemAtIndex(index: int):
	if index<0 || index>=slots.size() || !slots[index].item:
		return
	if slots[index].amount == 1:
		slots[index].amount-=1
		removeAtIndex(index)
	else:
		slots[index].amount -= 1
		updated.emit()
		
func insertSlot(index: int, inventorySlot: InventorySlot):
	var oldIndex: int = slots.find(inventorySlot)
	removeAtIndex(index)
	slots[index] = inventorySlot
	
func getItemIndex(name: String):
	var index=0
	for i in slots:
		if i.item and i.item.creatureName == name:
			return index
		index+=1
		
func removeItemByName(name: String):
	useItemAtIndex(getItemIndex(name))
	
func hasLettuce():
	for i in slots:
		if not(i.item == null) and i.item.creatureName == "Lettuce":
			return true
