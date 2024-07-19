extends Control

@onready var main = $"../.."
@onready var saveManager = $SaveManager

var images = [	preload("res://Assets/Images/Tutorial/Slide0.png"),
				preload("res://Assets/Images/Tutorial/Slide1.png"),
				preload("res://Assets/Images/Tutorial/Slide2.png"),
				preload("res://Assets/Images/Tutorial/Slide3_0.png")]

var mainMenu = load("res://Scenes/MainTitle.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	$TutorialMenu.load_images(images)
	
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
	saveManager.delete_data()
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


func _on_tutorial_pressed():
	$TutorialMenu.show()
	_button_pressed_sound()
	pass # Replace with function body.


func _on_tutorial_mouse_entered():
	_button_hover_sound()
	pass # Replace with function body.
