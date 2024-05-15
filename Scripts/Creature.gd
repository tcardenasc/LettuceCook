extends CharacterBody2D
class_name Creature

@onready var health_bar = $HealthBar
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot = $pivot
@onready var tameLabel: Label = $tameLabel

@export var MAX_HEALTH = 0
@export var target: CharacterBody2D = null
var target_detected = false
var target_on_attack_range = false
@export var movementSpeed = 100
var movementAttackPenalty = 50
var knockback = Vector2.ZERO
@export var basicDamage = 10
var stunned = false
var in_tame_range = false
var health:
	set(value):
		if health != value:
			health = value
			set_health_bar()
			if (health == 0):
				stunned = true;
				tameLabel.show()

func _ready():
	animation_tree.active = true
	health = MAX_HEALTH
	health_bar.max_value = MAX_HEALTH
	set_health_bar()

func _physics_process(delta):
	if health == 0:
		playback.travel("stunned")
		return
	
	if target and global_position.distance_to(target.global_position) > 20:
		var direction = global_position.direction_to(target.global_position)
		velocity = direction * movementSpeed + knockback
	else:
		velocity = Vector2.ZERO + knockback
	move_and_slide()
	knockback = lerp(knockback, Vector2.ZERO, 0.1)
	
	# animation
	if velocity.x or velocity.y:
		playback.travel("walk")
	else:
		playback.travel("idle")
	
	if (velocity.x):
		pivot.scale.x = sign(velocity.x)
		
	if(target_on_attack_range):
		playback.travel("attack")
		return

func set_health_bar():
	health_bar.value = health

func receive_damage(damage):
	health = max(health - damage, 0)

func _on_attack_area_body_entered(body):
	if (body == target):
		movementSpeed-=movementAttackPenalty
		target_on_attack_range = true
		in_tame_range = true

func _on_attack_area_body_exited(body):
	if (body == target):
		movementSpeed+=movementAttackPenalty
		target_on_attack_range = false
		in_tame_range = false

func attack():
	print("attack")
	if target_on_attack_range:
		target.recieve_damage(basicDamage)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use") and stunned and in_tame_range:
		#player.picked.emit(name)
		picked()
		
func picked():
	queue_free()
