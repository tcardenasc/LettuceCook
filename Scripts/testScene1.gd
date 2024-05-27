extends Node2D

@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var player = $Player
@onready var brain_spawner = $BrainSpawner
@onready var eduardo_spawner = $EduardoSpawner
@onready var playerStatus = $CanvasLayer/Inventory
@onready var inventoryGui = $CanvasLayer/InventoryGui
@onready var summoner = $Summoner

var paused = false

func _ready():
	# Assign player scene to creature spawners
	for spawner:CreatureSpawner in find_children("*", "CreatureSpawner"):
		spawner.player = player
	inventoryGui.summon.connect(_on_summon)

func pause_game():
	if paused:
		pause_menu.hide()
		playerStatus.show()
		inventoryGui.show()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		playerStatus.hide()
		inventoryGui.hide()
		Engine.time_scale = 0
		
	paused = !paused
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	playerStatus._update_health(player.health)
	playerStatus._update_gems(player.gems)
	if Input.is_action_just_pressed("escape"):
		pause_game()
	pass
	
func _on_summon(itemName):
	print(itemName)
	summoner.summon(itemName)
	

