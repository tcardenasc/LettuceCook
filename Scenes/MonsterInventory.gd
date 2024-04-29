extends GridContainer

# Array para almacenar referencias a los TextureRect
var inventory_slots = []

func _ready():
	# Obtener referencias a los TextureRect hijos
	for child in get_children():
		inventory_slots.append(child)

func _input(event):
	if event is InputEventKey and event.pressed:
		# Manejar la selección según el número presionado
		match event.keycode:
			KEY_1:
				select_slot(0)
			KEY_2:
				select_slot(1)
			KEY_3:
				select_slot(2)
			KEY_4:
				select_slot(3)
			KEY_5:
				select_slot(4)
			KEY_6:
				select_slot(5)
			KEY_7:
				select_slot(6)
			KEY_8:
				select_slot(7)
			KEY_9:
				select_slot(8)

# Función para seleccionar un slot de inventario
func select_slot(index):
	# Deseleccionar el slot anterior
	for slot in inventory_slots:
		slot.self_modulate = Color.WHITE
	
	# Seleccionar el nuevo slot
	inventory_slots[index].self_modulate = Color.YELLOW_GREEN

# Función para asignar una textura al slot seleccionado
func set_item_texture(texture, slot_index):
	inventory_slots[slot_index].texture = texture
