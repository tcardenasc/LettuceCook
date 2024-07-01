extends CharacterBody2D
class_name Player

@onready var health_points = $HealthBar
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot = $pivot
@onready var attack_area = $pivot/AttackArea
@onready var attack_sfx = $AttackSFX
@export var speed = 300
@export var damage = 5
@export var knockback_strenght = 1000
@export var inventory: Inventory

const MAX_HEALTH = 500
var current_gems = 0
var all_gems_collected = 0
var health = MAX_HEALTH
var brain_defeated = 0
var eduardo_defeated = 0

const bulletPath = preload('res://Scenes/Lettuce.tscn')

func _ready():
	attack_area.body_entered.connect(_on_attack_body_entered)
	
func _on_attack_body_entered(body: Node2D):
	if (body is CharacterBody2D):
		var direction = global_position.direction_to(body.global_position)
		body.knockback = direction * knockback_strenght 
		body.receive_damage(damage)
		
func _on_area_2d_body_entered(body):
	if body.is_in_group("Gemas"):
		body.queue_free()
		current_gems += 1
		all_gems_collected += 1 
		get_parent().updatePlayerInfo()



func _physics_process(delta):
	velocity = Input.get_vector("left", "right", "up", "down")*speed
	move_and_slide()
	$aim.look_at(get_global_mouse_position())
	
	if(Input.is_action_just_pressed("attack")):
		playback.travel("attack_1")
		return
	
	if(Input.is_action_just_pressed("shoot")):
		if inventory.hasLettuce():
			shoot_lettuce()
			inventory.removeItemByName("Lettuce")
	
	# animation
	if velocity.x or velocity.y:
		playback.travel("walk")
	else:
		playback.travel("idle")
	
	if (velocity.x):
		pivot.scale.x = sign(velocity.x)

func receive_damage(amount):
	health = max(health - amount, 0)
	get_parent().updatePlayerInfo()
	if(health == 0):
		get_parent().playerDefeated()
 
func shoot_lettuce():
	var bullet = bulletPath.instantiate()
	get_parent().add_child(bullet)
	bullet.position = $aim/BulletPosition.global_position
	bullet.velocity = get_global_mouse_position() - bullet.position
	

func _on_animation_player_animation_started(anim_name):
	pass # Replace with function body.


func _on_animation_tree_animation_started(anim_name):
	if(anim_name=="attack_1"):
		attack_sfx.play()
	pass # Replace with function body.
	
	
func lost_game(saveManager):
	var save_data = {
		"max_health" : MAX_HEALTH,
		"speed" : speed,
		"damage" : damage,
		"current_gems": current_gems,
		"all_gems_collected": all_gems_collected,
		"brain_defeated": brain_defeated,
		"eduardo_defeated": eduardo_defeated
	}
	saveManager.save_data(save_data)

func won_level(saveManager):
	var save_data = {
		"max_health" : MAX_HEALTH,
		"speed" : speed,
		"damage" : damage,
		"current_gems": current_gems,
		"all_gems_collected": all_gems_collected,
		"brain_defeated": brain_defeated,
		"eduardo_defeated": eduardo_defeated
	}
	saveManager.save_data(save_data)
