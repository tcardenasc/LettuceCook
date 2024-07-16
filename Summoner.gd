extends Node2D

class_name Summoner

const brain = preload("res://Scenes/brain.tscn") 
const eduardo = preload("res://Scenes/eduardo.tscn")
const lettuce = preload("res://Scenes/Lettuce.tscn")
@export var player: CharacterBody2D
@export var summon_sound: AudioStream
var dict ={
	"Brain":brain,
	"Eduardo":eduardo,
	"Lettuce":lettuce
}

func summonBrain():
	var brainSummon = brain.instantiate() as Creature
	brainSummon.global_position = player.global_position
	add_child(brainSummon)
	
func summonEduardo():
	var eduardoSummon = eduardo.instantiate() as Creature
	eduardoSummon.global_position = player.global_position
	add_child(eduardoSummon)
	
func summon(mob_scene: String):
	if mob_scene=="Lettuce":
		player.shoot_lettuce()
		return
	var mob = dict[mob_scene].instantiate() as Creature
	mob.global_position = player.global_position
	mob.collision_layer = 0b10
	mob.collision_mask = 0b101
	
	mob.add_to_group("allies")
	add_child(mob)
	mob.sprite.self_modulate=Color.GREEN_YELLOW
	mob.attack_area.collision_mask = 0b100
	
	Dj.play_sound(summon_sound, -1)
	# lettuces are in layer 6, this makes it so that they can be hit by lettuces
	mob.set_collision_layer_value(0b110, true)
	#mob.set_collision_mask_value(0b110, true)
	# #########################
	mob.find_target()

func creatureDefeated():
	pass
