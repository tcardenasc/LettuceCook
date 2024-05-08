extends CharacterBody2D

@export var movement_speed = 0
const MAX_HEALTH = 20

@onready var health_bar = $HealthBar
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot = $pivot

var movementSpeed = 100
var player_detected = false
@export var player: CharacterBody2D = null
var knockback = Vector2.ZERO
var health = MAX_HEALTH:
	set(value):
		if health != value:
			health = value
			set_health_bar()
			if (health == 0):
				playback.travel("stunned")

func _ready():
	animation_tree.active = true
	health_bar.max_value = MAX_HEALTH
	set_health_bar()

func _physics_process(delta):
	if health == 0:
		return
	
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * movementSpeed*delta + knockback
		move_and_collide(velocity)
		knockback = lerp(knockback, Vector2.ZERO, 0.1)
	
	# animation
	if velocity.x or velocity.y:
		playback.travel("walk")
	else:
		playback.travel("idle")
	
	if (velocity.x):
		pivot.scale.x = sign(velocity.x)

func set_health_bar():
	health_bar.value = health

func receive_damage(damage):
	health = max(health - damage, 0)
