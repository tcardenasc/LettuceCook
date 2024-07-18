extends CreatureSpawner


# Called when the node enters the scene tree for the first time.
func _ready():
	defeated = true
	spawn_lettuce()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	spawn_lettuce()
	if (spawned == spawn_limit):
		timer.stop()
		return

func spawn_lettuce():
	var lettuce = mob_scene.instantiate() as Lettuce
	add_child(lettuce)
	#var player_position= get_parent().player.position
	#lettuce.position.x=randf_range(player_position.x-500,player_position.x+500)
	#lettuce.position.y=randf_range(player_position.y-500,player_position.y+500)
	lettuce.position.x=randf_range(-160,1100)
	lettuce.position.y=randf_range(-670,60)
	lettuce._collectable_particles.emitting=true
	lettuce._traveling_particles.emitting=false
	
	Dj.play_sound(spawn_sound,-1)
	spawned += 1
	
