extends Control

@onready var main = $"."

var firstLevel = load("res://Scenes/testScene1.tscn")
var mainMenu = load("res://Scenes/MainTitle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _press_button():
	$PressSound.play()

func _hover_button():
	$HoverSound.play()
	
func _on_main_menu_pressed():
	main.get_tree().change_scene_to_packed(mainMenu)
	_press_button()
	pass # Replace with function body.


func _on_new_game_pressed():
	main.get_tree().change_scene_to_packed(firstLevel)
	_press_button()
	pass # Replace with function body.


func _on_exit_game_pressed():
	main.get_tree().quit()
	_press_button()
	pass # Replace with function body.

func _on_exit_game_mouse_entered():
	_hover_button()
	pass # Replace with function body.


func _on_new_game_mouse_entered():
	_hover_button()
	pass # Replace with function body.



func _on_main_menu_mouse_entered():
	_hover_button()
	pass # Replace with function body.
