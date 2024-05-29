extends Control

@onready var main = $"."
@onready var saveManager = $SaveManager

var current_gems = 0
var all_gems_collected = 0
var brain_defeated = 0
var eduardo_defeated = 0
var max_health = 0
var damage = 0
var speed = 0	
var saved_data

var mainTitle = load("res://Scenes/MainTitle.tscn")

var firstLevel = load("res://Scenes/testScene1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	saved_data = saveManager.load_data()
	if not saved_data.is_empty():
		max_health = saved_data.get("max_health",0)
		damage = saved_data.get("damage", 0)
		speed = saved_data.get("speed", 0)
		current_gems = saved_data.get("current_gems", 0)
		all_gems_collected = saved_data.get("all_gems_collected", 0)
		brain_defeated = saved_data.get("brain_defeated", 0)
		eduardo_defeated = saved_data.get("eduardo_defeated", 0)
	
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
