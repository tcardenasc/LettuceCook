extends Node2D

@onready var pause_menu = $CanvasLayer/PauseMenu
var paused = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func pause_game():
	if paused:
		pause_menu.hide()
		$CanvasLayer/Inventory.show()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		$CanvasLayer/Inventory.hide()
		Engine.time_scale = 0
		
	paused = !paused
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		pause_game()
	pass
