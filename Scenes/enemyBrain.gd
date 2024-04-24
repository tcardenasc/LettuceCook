extends CharacterBody2D

var movementSpeed = 100
var player_detected = false
var player: CharacterBody2D = null
var knockback = Vector2.ZERO


#func _physics_process(delta):
	#if player_detected:
		#$AnimatedSprite2D.play("running")
		#position += (player.position - position)/speed
	#else:
		#$AnimatedSprite2D.play("idle")
		
		
func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
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
	


func _on_detection_area_body_exited(body):
	player = null
	player_detected = false
	$AnimatedSprite2D.play("idle")


