extends Node2D
class_name CreatureSpawner

@onready var timer = $Timer

@export var mob_scene: PackedScene
@export var player: CharacterBody2D
@export var spawn_limit: int

var spawned = 0

func _on_timer_timeout():
	if (spawned == spawn_limit):
		timer.stop()
		return
	var mob = mob_scene.instantiate() as Creature
	mob.target = player
	add_child(mob)
	spawned += 1
