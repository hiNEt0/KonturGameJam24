class_name ExperienceManager
extends Node

@onready var exp = 0
@onready var level = 1
@onready var next_exp_goal = 5

@export var explosion_caster: PackedScene
@export var shotgun_caster: PackedScene

var inv_manager: InventoryManager


func add_exp(amount):
	exp += amount
	if exp >= next_exp_goal:
		level_up()


func level_up():
	level += 1
	exp = 0
	if level == 2:
		get_reward_1()
	if level == 3:
		get_reward_2()
	
	next_exp_goal = get_exp_goal()
	

func get_exp_goal():
	return 5 * level


func on_enemy_killed():
	add_exp(1)


func get_reward_1():
	inv_manager.add_spell(explosion_caster.instantiate(), KEY_J)


func get_reward_2():
	inv_manager.add_spell(shotgun_caster.instantiate(), KEY_K)


func assign_inv_manager(node):
	inv_manager = node
