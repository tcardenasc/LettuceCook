extends Control

var config_file = ConfigFile.new()
var config_path = "user://settings.cfg"
var resolutions : Dictionary = {"2560x1440":Vector2i(2560,1440),
								"1920x1440":Vector2i(1920,1440),
								"1600x900":Vector2i(1600,900),
								"1536x864":Vector2i(1536,864),
								"1440x900":Vector2i(1440,900),
								"1366x768":Vector2i(1366,768),
								"1024x600":Vector2i(1024,600),
								"800x600":Vector2i(800,600)}

func _ready():
	hide()
	add_resolutions()
	load_settings()
	check_variables()
	pass 
	
func add_resolutions():
	
	var current_resolution = get_window().get_size()
	
	for r in resolutions:
		$Resolution.add_item(r)

func add_screen_modes():
	$FullscreenMode.add_item("Fullscreen",)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resolution_pressed():
	pass # Replace with function body.

func _on_global_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),linear_to_db($MasterVolume.value))
	pass # Replace with function body.


func _on_music_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db($MusicVolume.value))
	pass # Replace with function body.


func _on_sfx_volume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound Effects"),linear_to_db($SfxVolume.value))
	pass # Replace with function body.


func _on_resolution_item_selected(index):
	var id = $Resolution.get_item_text(index)
	$Resolution.select(index)
	get_window().set_size(resolutions[id])
	centre_window()
	pass # Replace with function body.
	
func _on_fullscreen_mode_toggled(toggled_on):
	if toggled_on:
		get_window().set_mode(Window.MODE_FULLSCREEN)
		
	else:
		get_window().set_mode(Window.MODE_WINDOWED)
		centre_window()
	pass # Replace with function body.
	
	
func centre_window():
	var centre_of_screen = DisplayServer.screen_get_position()+DisplayServer.screen_get_size()/2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(centre_of_screen-window_size/2)

func check_variables():
	var _window = get_window()
	var mode = _window.get_mode()
	
	if mode == Window.MODE_FULLSCREEN:
		$FullscreenMode.set_pressed_no_signal(true)
	
func load_settings():
	# Cargar las configuraciones guardadas desde el archivo
	var err = config_file.load(config_path)
	if err != OK:
	# Error al cargar el archivo, usar configuraciones predeterminadas
		return

	# Cargar las opciones de configuración desde el archivo
	var is_fullscreen = config_file.get_value("display", "fullscreen_mode", false)
	$FullscreenMode.button_pressed = is_fullscreen

	if is_fullscreen:
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
	else:
		get_window().mode = Window.MODE_WINDOWED

	var resolution_index = config_file.get_value("display", "resolution_index", 0)
	_on_resolution_item_selected(resolution_index)

	var music_volume = config_file.get_value("audio", "music_volume", 0)
	$MusicVolume.value = music_volume

	var sfx_volume = config_file.get_value("audio", "sfx_volume", 0)
	$SfxVolume.value = sfx_volume

	var master_volume = config_file.get_value("audio", "master_volume", 0)
	$MasterVolume.value = master_volume

func save_setting():
	config_file.set_value("display", "fullscreen_mode", $FullscreenMode.button_pressed)
	config_file.set_value("display", "resolution_index", $Resolution.selected)
	config_file.set_value("audio", "music_volume", $MusicVolume.value)
	config_file.set_value("audio", "sfx_volume", $SfxVolume.value)
	config_file.set_value("audio", "master_volume", $MasterVolume.value)
	
	var err = config_file.save(config_path)
	if err != OK:
		print("Error al guardar las configuraciones")

func _on_close_pressed():
	save_setting()
	hide()
	pass # Replace with function body.
