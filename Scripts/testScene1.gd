extends Node2D

@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var player = $Player
@onready var brain_spawner = $BrainSpawner
@onready var eduardo_spawner = $EduardoSpawner
@onready var inventory = $CanvasLayer/Inventory

var paused = false

func _ready():
	# Assign player scene to creature spawners
	for spawner:CreatureSpawner in find_children("*", "CreatureSpawner"):
		spawner.player = player

func pause_game():
	if paused:
		pause_menu.hide()
		inventory.show()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		inventory.hide()
		Engine.time_scale = 0
		
	paused = !paused
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	inventory._update_health(player.health)
	inventory._update_gems(player.gems)
	if Input.is_action_just_pressed("escape"):
		pause_game()
	pass
