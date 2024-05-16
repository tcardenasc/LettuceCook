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
		# KEY_1 - KEY_9 numeros consecutivos
		if (KEY_1 <= event.keycode and event.keycode <= KEY_9):
			select_slot(event.keycode % KEY_1)

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
