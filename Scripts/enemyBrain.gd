extends CharacterBody2D

@onready var health_bar = $HealthBar

const MAX_HEALTH = 20
signal health_changed

var health = MAX_HEALTH:
	set(value):
		if health != value:
			health = value
			health_changed.emit()

var movementSpeed = 100
var player_detected = false
var player: CharacterBody2D = null
var knockback = Vector2.ZERO

func _ready():
	$AnimatedSprite2D.play("idle")
	health_bar.max_value = MAX_HEALTH
	set_health_bar()
	health_changed.connect(_on_healh_changed)

func _physics_process(delta):
	if health == 0:
		return
	if player_detected:
		$AnimatedSprite2D.play("running")
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * movementSpeed*delta + knockback
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
		velocity = lerp(velocity, Vector2.ZERO, 0.07)
	move_and_collide(velocity)
	knockback = lerp(knockback, Vector2.ZERO, 0.1)
	
func _on_detection_area_body_entered(body):
	if (body is CharacterBody2D):
		player = body
		player_detected = true

func _on_detection_area_body_exited(_body):
	player = null
	player_detected = false

func set_health_bar():
	health_bar.value = health

func _on_healh_changed():
	set_health_bar()
	if (health == 0):
		$AnimatedSprite2D.play("stunned")
	

func receive_damage(damage):
	health = max(health - damage, 0)
