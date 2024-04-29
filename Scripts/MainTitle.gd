extends Control

const TEST_SCENE_1 = preload("res://Scenes/testScene1.tscn")

func _ready():
	var button1 = $Start
	var button2 = $Continue
	var button3 = $Settings
	var button4 = $Exit

func _on_start_pressed():
	_button_pressed_sound()
	get_tree().change_scene_to_packed(TEST_SCENE_1)

func _on_continue_pressed():
	_button_pressed_sound()
	pass # Replace with function body.


func _on_settings_pressed():
	_button_pressed_sound()
	$CanvasLayer/SettingsMenu.show()
	pass # Replace with function body.


func _on_exit_pressed():
	_button_pressed_sound()
	get_tree().quit()
	pass # Replace with function body.
	
func _button_pressed_sound():
	$ButtonPressSound.play()
	
func _button_hover_sound():
	$ButtonHoverSound.play()


func _on_start_mouse_entered():
	_button_hover_sound()
	pass # Replace with function body.


func _on_continue_mouse_entered():
	_button_hover_sound()
	pass # Replace with function body.


func _on_settings_mouse_entered():
	_button_hover_sound()
	pass # Replace with function body.


func _on_exit_mouse_entered():
	_button_hover_sound()
	pass # Replace with function body.
