extends Node

const SAVE_FILE_PATH = "user://save_data.json"

func save_data(data):
	var saved_data = load_data()
	if saved_data.is_empty():
		# Si save_data estaba vacío, guarda los datos tal como están
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
		file.store_string(JSON.stringify(data))
		file.close()
	else:
		# Si save_data no estaba vacío, actualiza los datos existentes
		saved_data["max_health"] = data["max_health"]
		saved_data["speed"] = data["speed"]
		saved_data["damage"] = data["damage"]
		saved_data["current_gems"] = data["current_gems"]
		saved_data["all_gems_collected"] += data["all_gems_collected"]
		saved_data["brain_defeated"] += data["brain_defeated"]
		saved_data["eduardo_defeated"] += data["eduardo_defeated"]
		saved_data["dino_defeated"] += data["dino_defeated"]

		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
		file.store_string(JSON.stringify(saved_data))
		file.close()


func update_player(data):
	var saved_data = load_data()
	saved_data["max_health"] = data.get("max_health", 0)
	saved_data["damage"] = data.get("damage", 0)
	saved_data["speed"] = data.get("speed",0)
	saved_data["current_gems"] = data.get("current_gems",0)
	save_data(saved_data)

func load_data():
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		file.close()
		return data
	else:
		return {}

func delete_data():
	if FileAccess.file_exists(SAVE_FILE_PATH):
		DirAccess.remove_absolute(SAVE_FILE_PATH)
