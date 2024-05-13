extends Node

@export var mob_scene: PackedScene
@export var player: CharacterBody2D
@export var spawn_limit: int
var spawned = 0

@onready var timer = $Timer

func _on_timer_timeout():
	if (spawned == spawn_limit):
		timer.stop()
		return
	var mob = mob_scene.instantiate() as Creature
	mob.target = player
	var spawn_location = Vector2(4352, -2664)
	mob.global_position = spawn_location
	add_child(mob)
	spawned += 1
