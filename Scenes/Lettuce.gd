extends CharacterBody2D

var speed = 300
var healing_amount = 15
@export var traveling_particles : PackedScene
@export var hit_particles : PackedScene
var _traveling_particles : GPUParticles2D
var _hit_particles : GPUParticles2D

func _ready():
	spawn_travel_particles()

func spawn_travel_particles():
	
	_traveling_particles = traveling_particles.instantiate()
	_hit_particles = hit_particles.instantiate()
	_traveling_particles.position = global_position
	_traveling_particles.emitting = true 
	add_child(_traveling_particles)	
	#_traveling_particles.rotation = global_rotation
	
		
func _physics_process(delta):
	#position += speed*delta
	var collision_info = move_and_collide(velocity.normalized()*delta*speed)

func _on_area_2d_body_entered(body):
	if(body is Creature):
		if (body.stunned):
			body.picked(body.player_inventory)
			body.queue_free()
		elif body.is_in_group("allies"):
			body.receive_heal(healing_amount)
			print("healed")
	hit_object()

func hit_object():
	_hit_particles = hit_particles.instantiate()
	_hit_particles.position = global_position
	_hit_particles.emitting = true
	get_tree().current_scene.add_child(_hit_particles)
	_traveling_particles.emitting = false
	queue_free()
	
func _on_vanish_lettuce_timeout():
	queue_free()
