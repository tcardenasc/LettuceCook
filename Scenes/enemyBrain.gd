extends CharacterBody2D

var movementSpeed = 100
var player_detected = false
var player = null


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
		velocity = (player.get_global_position() - position).normalized() * movementSpeed * delta
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
		velocity = lerp(velocity, Vector2.ZERO, 0.07)
	move_and_collide(velocity)
	
func _on_detection_area_body_entered(body):
	player = body
	player_detected = true
	


func _on_detection_area_body_exited(body):
	player = null
	player_detected = false
	$AnimatedSprite2D.play("idle")


