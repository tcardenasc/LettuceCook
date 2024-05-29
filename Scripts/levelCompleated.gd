extends Control

@onready var main = $"."

var mainTitle = load("res://Scenes/MainTitle.tscn")

var firstLevel = load("res://Scenes/testScene1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _hover_button():
	$HoverSound.play()


func _on_continue_pressed():
	pass # Replace with function body.


func _on_continue_mouse_entered():
	_hover_button()
	pass # Replace with function body.


func _on_mainmenu_pressed():
	main.get_tree().change_scene_to_packed(mainTitle)
	pass # Replace with function body.


func _on_mainmenu_mouse_entered():
	_hover_button()
	pass # Replace with function body.


func _on_exit_pressed():
	main.get_tree().quit()
	pass # Replace with function body.


func _on_exit_mouse_entered():
	_hover_button()
	pass # Replace with function body.


func _on_new_game_pressed():
	main.get_tree().change_scene_to_packed(firstLevel)
	pass # Replace with function body.


func _on_new_game_mouse_entered():
	_hover_button()
	pass # Replace with function body.
