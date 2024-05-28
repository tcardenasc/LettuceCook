extends Node2D
class_name CreatureSpawner

@onready var timer = $Timer

@export var mob_scene: PackedScene
@export var player: CharacterBody2D
@export var spawn_limit: int
var defeated = false
var remaining_creatures = spawn_limit

var spawned = 0

func _ready():
	remaining_creatures = spawn_limit

func _on_timer_timeout():
	if (spawned == spawn_limit):
		timer.stop()
		return
	var mob = mob_scene.instantiate() as Creature
	mob.target = player
	add_child(mob)
	spawned += 1

func creatureDefeated():
	remaining_creatures -= 1
	if(remaining_creatures == 0):
		defeated = true
		get_parent().spawnerDefeated()
