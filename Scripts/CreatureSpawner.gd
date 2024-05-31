extends Node2D
class_name CreatureSpawner

@onready var timer = $Timer

@export var mob_scene: PackedScene
@export var player: CharacterBody2D
@export var spawn_limit: int
var defeated = false
var remaining_creatures = spawn_limit
var creatures_defeated = 0

var spawned = 0

func _ready():
	remaining_creatures = spawn_limit

# Spawn creature as enemy
func _on_timer_timeout():
	if (spawned == spawn_limit):
		timer.stop()
		return
	var mob = mob_scene.instantiate() as Creature
	mob.player = player
	mob.add_to_group("enemies")
	add_child(mob)
	spawned += 1

func creatureDefeated():
	remaining_creatures -= 1
	creatures_defeated = spawn_limit - remaining_creatures
	get_parent().updatePlayerInfo()
	if(remaining_creatures == 0):
		defeated = true
		get_parent().spawnerDefeated()
