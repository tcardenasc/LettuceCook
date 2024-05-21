extends CharacterBody2D
#var bullet_velocity = Vector2(0,0)
var speed = 300
func _physics_process(delta):
	#position += speed*delta
	var collision_info = move_and_collide(velocity.normalized()*delta*speed)

func _on_area_2d_body_entered(body):
	if(body is Creature):
		if (body.stunned):
			body.picked(body.player_inventory)
			body.queue_free()
	queue_free()
