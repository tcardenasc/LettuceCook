extends CharacterBody2D


@export var speed = 300
@export var knockback_strenght = 15

@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot = $pivot
@onready var attack_area = $pivot/AttackArea

func _ready():
	attack_area.body_entered.connect(_on_attack_body_entered)
	
func _on_attack_body_entered(body: Node2D):
	if (body is CharacterBody2D):
		var direction = global_position.direction_to(body.global_position)
		body.knockback = direction * knockback_strenght 
		print("empuje a un enemigo")

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
	
