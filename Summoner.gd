extends Node2D

class_name Summoner

const brain = preload("res://Scenes/brain.tscn") 
const eduardo = preload("res://Scenes/eduardo.tscn")
@export var player: CharacterBody2D

var dict ={
	"Brain":brain,
	"Eduardo":eduardo
}

func summonBrain():
	var brainSummon = brain.instantiate() as Creature
	brainSummon.global_position = player.global_position
	add_child(brainSummon)
	
func summonEduardo():
	var eduardoSummon = eduardo.instantiate() as Creature
	eduardoSummon.global_position = player.global_position
	add_child(eduardoSummon)
	
func summon(mob_scene):
	var mob = dict[mob_scene].instantiate() as Creature
	mob.global_position = player.global_position
	mob.add_to_group("allies")
	mob.collision_layer = 0b10
	mob.collision_mask = 0b101
	add_child(mob)
	mob.attack_area.collision_mask = 0b100

func creatureDefeated():
	pass
