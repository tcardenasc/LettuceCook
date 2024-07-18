extends Control

@onready var main = $"."
@onready var saveManager = $SaveManager
@onready var brainKilledLabel = $BrainKilledBadge/BrainKilled
@onready var eduKilledLabel = $EduKilledBadge/EduKilled
@onready var damageLabel = $Control/Damage
@onready var speedLabel = $Control/Speed
@onready var currentGemsLabel = $Control/Gem
@onready var totalGemsLabel = $Control/Gem2
@onready var maxHealthLabel = $Control/Health

const firstLevel = preload("res://Scenes/Levels/grass_scene.tscn")
var mainMenu = load("res://Scenes/MainTitle.tscn")
var current_gems = 0
var all_gems_collected = 0
var brain_defeated = 0
var eduardo_defeated = 0
var max_health = 0
var damage = 0
var speed = 0
var saved_data
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
		
	maxHealthLabel.text = str(max_health)
	damageLabel.text = str(damage)
	speedLabel.text = str(speed)
	currentGemsLabel.text = str(current_gems)
	totalGemsLabel.text = str(all_gems_collected)
	eduKilledLabel.text = str(eduardo_defeated)
	brainKilledLabel.text = str(brain_defeated)
	
	
	print(str(brain_defeated))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _press_button():
	$PressSound.play()

func _hover_button():
	$HoverSound.play()
	
func _on_main_menu_pressed():
	_press_button()
	main.get_tree().change_scene_to_packed(mainMenu)
	pass # Replace with function body.


func _on_new_game_pressed():
	saveManager.delete_data()
	_press_button()
	main.get_tree().change_scene_to_packed(firstLevel)
	pass # Replace with function body.


func _on_exit_game_pressed():
	_press_button()
	main.get_tree().quit()
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
