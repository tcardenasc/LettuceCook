extends Panel

class_name ItemStackGui


@onready var itemSprite: Sprite2D = $item
@onready var amountLabel: Label = $itemAmount
var inventorySlot: InventorySlot

func update():
	#checkear si el slot o su item son nulos
	if !inventorySlot || !inventorySlot.item: return

	itemSprite.texture = inventorySlot.item.texture
	itemSprite.visible = true
	if inventorySlot.item.maxStackAmount > 1:
		amountLabel.text = str(inventorySlot.amount)
		amountLabel.visible = true
	else:
		amountLabel.visible = false
		
