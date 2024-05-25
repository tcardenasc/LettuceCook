extends Panel


@onready var backgroundSprite: Sprite2D = $background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/item
@onready var amountLabel: Label = $CenterContainer/Panel/itemAmount
func update(slot: InventorySlot):
	if !slot.item: 
		backgroundSprite.frame = 0
		itemSprite.visible = false
		amountLabel.visible = false
	else:
		backgroundSprite.frame = 1
		itemSprite.texture = slot.item.texture
		itemSprite.visible = true
		if slot.item.maxStackAmount != 1:
			amountLabel.text = str(slot.amount)
			amountLabel.visible=true
		
