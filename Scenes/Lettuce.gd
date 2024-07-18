extends CharacterBody2D
class_name Lettuce
var speed = 300
var healing_amount = 15
@export var traveling_particles : PackedScene
@export var hit_particles : PackedScene
@export var hit_sound : AudioStream
@onready var _traveling_particles : GPUParticles2D = traveling_particles.instantiate()
var _hit_particles : GPUParticles2D
@onready var vanish_timer: Timer = $vanishLettuce
var collectable:bool = true
var player_inventory: Inventory = preload("res://Scenes/Inventory/playerInventory.tres")
@export var itemResource: InventoryItem

func _ready():
	vanish_timer.stop()
	

func spawn_travel_particles():
	_hit_particles = hit_particles.instantiate()
	_traveling_particles.position = global_position
	_traveling_particles.emitting = true 
	add_child(_traveling_particles)	
	#_traveling_particles.rotation = global_rotation
	
		
func _physics_process(delta):
	#position += speed*delta
	var collision_info = move_and_collide(velocity.normalized()*delta*speed)

func _on_area_2d_body_entered(body):
	if (body is Player):
		if collectable:
			picked()
	elif (body is Creature):
		if (body.stunned):
			body.picked(body.player_inventory)
			body.queue_free()
		elif body.is_in_group("allies"):
			body.receive_heal(healing_amount)
		hit_object()
	else:
		hit_object()

func hit_object():
	_hit_particles = hit_particles.instantiate()
	_hit_particles.position = global_position
	_hit_particles.emitting = true
	get_tree().current_scene.add_child(_hit_particles)
	_traveling_particles.emitting = false
	Dj.play_sound(hit_sound,7)
	
	queue_free()
	
func _on_vanish_lettuce_timeout():
	queue_free()

func picked():
	player_inventory.insert(itemResource)
	queue_free()
	
