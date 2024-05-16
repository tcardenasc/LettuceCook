extends Node2D

@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var player = $Player
@onready var brain_spawner = $BrainSpawner
@onready var eduardo_spawner = $EduardoSpawner

var paused = false
func _ready():
	# Assign player scene to creature spawners
	for spawner:CreatureSpawner in find_children("*", "CreatureSpawner"):
		spawner.player = player

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
