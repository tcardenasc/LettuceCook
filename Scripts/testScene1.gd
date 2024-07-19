extends Node2D

@onready var main = $"."
@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var player = $Player
@onready var brain_spawner = $BrainSpawner
@onready var eduardo_spawner = $EduardoSpawner
@onready var dino_spawner = $DinoSpawner
@onready var playerStatus = $CanvasLayer/Inventory
@onready var inventoryGui = $CanvasLayer/InventoryGui
@onready var summoner = $Summoner
@onready var saveManager = $SaveManager

var gameOverScene = load("res://Scenes/gameOverMenu.tscn")

var levelCompleatedScene = load("res://Scenes/levelCompleated.tscn")

var paused = false

func _ready():
	# Assign player scene to creature spawners
	for spawner:CreatureSpawner in find_children("*", "CreatureSpawner"):
		spawner.player = player
	summoner.player = player
		
	updatePlayerInfo()
	
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
	playerStatus._update_gems(player.current_gems)
	if Input.is_action_just_pressed("escape"):
		pause_game()
	pass
	
func _on_summon(itemName):
	print(itemName)
	summoner.summon(itemName)

func spawnerDefeated():
	var levelCompleated = true
	for spawner:CreatureSpawner in find_children("*", "CreatureSpawner"):
		if(spawner.defeated == false):
			levelCompleated = false
	if(levelCompleated):
		player.won_level(saveManager)
		main.get_tree().change_scene_to_packed(levelCompleatedScene)
		print("Felicitaciones!!")

func updatePlayerInfo():
	playerStatus._update_health(player.health)
	playerStatus._update_gems(player.current_gems)
	player.brain_defeated = brain_spawner.creatures_defeated
	player.eduardo_defeated = eduardo_spawner.creatures_defeated
	player.dino_defeated = dino_spawner.creatures_defeated 

func playerDefeated():
	player.lost_game(saveManager)
	main.get_tree().change_scene_to_packed(gameOverScene)
	print("game over")
