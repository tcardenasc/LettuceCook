extends Control

@onready var main = $"../.."

var mainMenu = load("res://Scenes/MainTitle.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _button_pressed_sound():
	$ButtonPressSound.play()
	
func _button_hover_sound():
	$ButtonHoverSound.play()


func _on_resume_pressed():
	_button_pressed_sound()
	main.pause_game()
	pass 


func _on_restart_pressed():
	_button_pressed_sound()
	main.pause_game()
	main.get_tree().reload_current_scene()
	pass 


func _on_quit_to_menu_pressed():
	_button_pressed_sound()
	main.pause_game()
	main.get_tree().change_scene_to_packed(mainMenu)
	pass
	


func _on_quit_game_pressed():
	_button_pressed_sound()
	main.get_tree().quit()
	pass 


func _on_resume_mouse_entered():
	_button_hover_sound()
	pass # Replace with function body.


func _on_restart_mouse_entered():
	_button_hover_sound()
	pass # Replace with function body.


func _on_settings_mouse_entered():
	_button_hover_sound()
	pass # Replace with function body.


func _on_quit_to_menu_mouse_entered():
	_button_hover_sound()
	pass # Replace with function body.


func _on_quit_game_mouse_entered():
	_button_hover_sound()
	pass # Replace with function body.


func _on_settings_pressed():
	_button_pressed_sound()
	$SettingsMenu.show()
	pass # Replace with function body.
