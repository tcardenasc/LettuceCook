extends CharacterBody2D
class_name Creature

@onready var health_bar = $HealthBar
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot = $pivot
@onready var tameLabel: Label = $tameLabel
@onready var vanishTimer = $vanishTimer
@onready var attackSfx = $AttackSFX
@export var healSfx : AudioStream
@export var capturedSfx : AudioStream
@export var stunnedSfx : AudioStream
@onready var attack_area: Area2D = $pivot/AttackArea

@onready var sprite = $pivot/Sprite

@export var MAX_HEALTH = 0
@export var target: CharacterBody2D = null
@export var player: Player = null
@export var movementSpeed = 100
@export var basicDamage = 10
@export var itemResource: InventoryItem

var player_inventory: Inventory = preload("res://Scenes/Inventory/playerInventory.tres")
const gema = preload("res://Scenes/gem.tscn")

signal born_or_died


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
				if is_in_group("allies"):
					remove_from_group("allies")
					vanishTimer.start()
				elif is_in_group("enemies"):
					remove_from_group("enemies")
					defeated()
					stunned_or_dead()
				born_or_died.emit()

func stunned_or_dead():
	for n in 5:
		soltar_gema()
	var probability = randi() % 100
	if(probability >= 50):
		Dj.play_sound(stunnedSfx, -2)
		stunned = true;
		$StunnedParticles.emitting = true
		#tameLabel.show()
	else:
		vanishTimer.start()
		collision_layer=0

func defeated():
	get_parent().creatureDefeated()

func _on_ready():
	born_or_died.emit()
	
func _on_born_or_died():
	if (is_inside_tree()):
		get_tree().call_group("allies", "find_target")
		get_tree().call_group("enemies", "find_target")

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
	ready.connect(_on_ready)
	born_or_died.connect(_on_born_or_died)

func _physics_process(delta):
	if health == 0:
		playback.travel("stunned")
		return
	
	if is_instance_valid(target) and global_position.distance_to(target.global_position) > 20:
		var direction = global_position.direction_to(target.global_position)
		velocity = direction * movementSpeed
	else:
		velocity = Vector2.ZERO
	velocity += knockback
	move_and_slide()
	knockback = lerp(knockback, Vector2.ZERO, 0.1)
	
	# animation
	if velocity.x or velocity.y:
		playback.travel("walk")
	else:
		playback.travel("idle")
	
	if (velocity.x):
		pivot.scale.x = sign(velocity.x)
		
	if(target_on_range()):
		playback.travel("attack")
		return

func set_health_bar():
	health_bar.value = health

func receive_damage(damage):
	health = max(health - damage, 0)
	
func receive_heal(heal):
	Dj.play_sound(healSfx, -1)
	health=min(health+heal, MAX_HEALTH)
	$HealingParticles.emitting = true
	
func target_on_range():
	return attack_area.overlaps_body(target)

func attack():
	attackSfx.play()
	if is_instance_valid(target) and target_on_range():
		target.receive_damage(basicDamage)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use") and stunned and in_tame_range:
		picked(player_inventory)

func picked(inventory: Inventory):
	#player.play_captured()
	Dj
	inventory.insert(itemResource)
	queue_free()

func _on_timer_timeout():
	queue_free()

func find_target():
	var target_group: Array[Node]
	if is_in_group("enemies") and is_inside_tree():
		target_group = get_tree().get_nodes_in_group("allies")
		if target_group.is_empty():
			target = player
			return
		elif target == player:
			target = null
	elif is_in_group("allies") and is_inside_tree():
		target_group = get_tree().get_nodes_in_group("enemies")
	else:
		return
		
	var nearest: CharacterBody2D = target if (is_instance_valid(target) and target.health>0) else null
	while(!target_group.is_empty()):
		var tmp = target_group.pop_back() as Creature
		if (!is_instance_valid(nearest) or global_position.distance_to(tmp.global_position) < global_position.distance_to(nearest.global_position)):
			nearest = tmp
	if nearest != null:
		#if is_instance_of(nearest, Creature) and !nearest.stunned:
		target = nearest
