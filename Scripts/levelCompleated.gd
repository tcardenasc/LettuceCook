extends Control

@onready var main = $"."
@onready var saveManager = $SaveManager
@onready var HealthLabel = $Control/HealthLabel
@onready var DamageLabel = $Control/DamageLabel
@onready var SpeedLabel = $Control/SpeedLabel
@onready var GemsLabel = $Control/GemsLabel
@onready var HealthCostLabel = $Control/HealthCostLabel
@onready var DamageCostLabel = $Control/DamageCostLabel
@onready var SpeedCostLabel = $Control/SpeedCostLabel

var current_gems = 0
var all_gems_collected = 0
var brain_defeated = 0
var eduardo_defeated = 0
var max_health = 0
var damage = 0
var speed = 0	
var saved_data

var health_upgrade = 50
var damage_upgrade = 1
var speed_upgrade = 30

var health_mp = 0
var damage_mp = 0
var speed_mp = 0

var health_cost = 5
var damage_cost = 5
var speed_cost = 5

const mainTitle = preload("res://Scenes/MainTitle.tscn")
const firstLevel = preload("res://Scenes/Levels/grass_scene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	_recover_data()
	_update_labels()
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
	
func _recover_data():
	saved_data = saveManager.load_data()
	if not saved_data.is_empty():
		max_health = saved_data.get("max_health",0)
		damage = saved_data.get("damage", 0)
		speed = saved_data.get("speed", 0)
		current_gems = saved_data.get("current_gems", 0)
		all_gems_collected = saved_data.get("all_gems_collected", 0)
		brain_defeated = saved_data.get("brain_defeated", 0)
		eduardo_defeated = saved_data.get("eduardo_defeated", 0)
		
func _update_labels():
	HealthLabel.text = str(max_health)
	DamageLabel.text = str(damage)
	SpeedLabel.text = str(speed)
	GemsLabel.text = str(current_gems)
	HealthCostLabel.text = str(health_cost)
	DamageCostLabel.text = str(damage_cost)
	SpeedCostLabel.text = str(speed_cost)

func _update_stats():
	max_health = int(HealthLabel.text)
	damage = int(DamageLabel.text)
	speed = int(SpeedLabel.text)
	current_gems = int(GemsLabel.text)


func _on_up_health_pressed():
	
	var gems = int(GemsLabel.text)
	
	if(gems >= health_cost):
		health_mp += 1
		HealthLabel.text = str(max_health + (health_upgrade*health_mp))
		GemsLabel.text = str(gems - health_cost)
		
	pass # Replace with function body.


func _on_down_health_pressed():
	
	var gems = int(GemsLabel.text)
	
	if(health_mp > 0):
		health_mp -= 1
		HealthLabel.text = str(max_health + (health_upgrade*health_mp))
		GemsLabel.text = str(gems + health_cost)
	
	pass # Replace with function body.


func _on_up_damage_pressed():
	var gems = int(GemsLabel.text)
	
	if(gems >= damage_cost):
		damage_mp += 1
		DamageLabel.text = str(damage + (damage_upgrade*damage_mp))
		GemsLabel.text = str(gems - damage_cost)
		
	pass # Replace with function body.


func _on_down_damage_pressed():
	var gems = int(GemsLabel.text)
	
	if(damage_mp > 0):
		damage_mp -= 1
		DamageLabel.text = str(damage + (damage_upgrade*damage_mp))
		GemsLabel.text = str(gems + damage_cost)
		
	pass # Replace with function body.


func _on_up_speed_pressed():
	var gems = int(GemsLabel.text)
	
	if(gems >= speed_cost):
		speed_mp += 1
		SpeedLabel.text = str(speed + (speed_upgrade*speed_mp))
		GemsLabel.text = str(gems - speed_cost)
	pass # Replace with function body.


func _on_down_speed_pressed():
	var gems = int(GemsLabel.text)
	
	if(speed_mp > 0):
		speed_mp -= 1
		SpeedLabel.text = str(speed + (speed_upgrade*speed_mp))
		GemsLabel.text = str(gems + speed_cost)
	pass # Replace with function body.


func _on_reset_pressed():
	_update_labels()
	health_mp = 0
	damage_mp = 0
	speed_mp = 0
	pass # Replace with function body.


func _on_confirm_pressed():
	_update_stats()
	health_mp = 0
	damage_mp = 0
	speed_mp = 0
	pass # Replace with function body.
