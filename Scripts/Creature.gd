extends CharacterBody2D
class_name Creature

@onready var health_bar = $HealthBar
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot = $pivot
@onready var tameLabel: Label = $tameLabel
@onready var timer = $Timer
@onready var attackSfx = $AttackSFX

@export var MAX_HEALTH = 0
@export var target: CharacterBody2D = null
@export var movementSpeed = 100
@export var basicDamage = 10

const gema = preload("res://Scenes/gem.tscn")

var target_detected = false
var target_on_attack_range = false
var movementAttackPenalty = 50
var knockback = Vector2.ZERO
var stunned = false
var in_tame_range = false
var health:
	set(value):
		if health != value:
			health = value
			set_health_bar()
			if (health == 0):
				for n in 5:
					soltar_gema()				
				var probability = randi() % 100
				if(probability >= 80):		
					stunned = true;
					tameLabel.show()
				else:
					timer.start()
					

func soltar_gema():
	var gema_instancia = gema.instantiate()
	get_parent().add_child(gema_instancia)
	gema_instancia.global_position = global_position
	var impulso_aleatorio = Vector2(randf_range(-300, 300), -300)
	gema_instancia.apply_central_impulse(impulso_aleatorio)
	
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
	attackSfx.play()
	if target_on_attack_range:
		target.recieve_damage(basicDamage)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use") and stunned and in_tame_range:
		#player.picked.emit(name)
		picked()

func picked():
	queue_free()


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
