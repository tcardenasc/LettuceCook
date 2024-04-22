extends CharacterBody2D


@export var speed = 300

@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot = $pivot

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
	
