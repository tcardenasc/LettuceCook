extends CharacterBody2D

const MAX_HEALTH = 500
var health = MAX_HEALTH
				
@onready var health_points = $HealthBar

@export var speed = 300
@export var damage = 5
@export var knockback_strenght = 1000

@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot = $pivot
@onready var attack_area = $pivot/AttackArea


func _ready():
	attack_area.body_entered.connect(_on_attack_body_entered)
	
func _on_attack_body_entered(body: Node2D):
	if (body is CharacterBody2D):
		var direction = global_position.direction_to(body.global_position)
		body.knockback = direction * knockback_strenght 
		body.receive_damage(damage)

func _physics_process(delta):
	velocity = Input.get_vector("left", "right", "up", "down")*speed
	move_and_slide()
	
	if(Input.is_action_just_pressed("attack")):
		playback.travel("attack_1")
		return
	
	# animation
	if velocity.x or velocity.y:
		playback.travel("walk")
	else:
		playback.travel("idle")
	
	if (velocity.x):
		pivot.scale.x = sign(velocity.x)

func recieve_damage(amount):
	health = max(health - amount, 0)
	print("health: ",health)
