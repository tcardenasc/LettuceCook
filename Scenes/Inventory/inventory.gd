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
	
func removeItemAtIndex(index: int):
	slots[index] = InventorySlot.new()

func insertSlot(index: int, inventorySlot: InventorySlot):
	var oldIndex: int = slots.find(inventorySlot)
	removeItemAtIndex(index)
	slots[index] = inventorySlot
	

