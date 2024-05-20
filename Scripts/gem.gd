extends RigidBody2D

@onready var timer1 = $Timer1
@onready var timer2 = $Timer2
@onready var body = $"."
@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	timer1.start()
	timer2.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_2_timeout():
	queue_free()
	pass # Replace with function body.


func _on_timer_1_timeout():
	body.linear_velocity = Vector2.ZERO
	body.angular_velocity = 0.0
	body.gravity_scale = 0
	pass # Replace with function body.

var coin = 1

func _on_timer_3_timeout():
	if(timer2.time_left <= 3.0):
		if coin == 1:
			sprite.modulate.a = 1
			coin = coin*(-1)
		else:
			sprite.modulate.a = 0.5
			coin = coin*(-1)
	pass # Replace with function body.
