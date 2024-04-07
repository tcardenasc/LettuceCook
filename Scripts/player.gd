extends CharacterBody2D


@export var speed = 300

@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

func _process(delta):
	velocity = Input.get_vector("left", "right", "up", "down")*speed
	
	move_and_slide()
	
	# animation
	if abs(velocity.x) > 10 or abs(velocity.y) > 10:
		playback.travel("walk")
	else:
		playback.travel("idle")
