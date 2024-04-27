class_name ExperienceManager
extends Node

@onready var exp = 0
@onready var level = 1
@onready var next_exp_goal = 2


func add_exp(amount):
	exp += amount
	print_debug("kill!", exp)
	if exp >= next_exp_goal:
		level_up()


func level_up():
	level += 1
	exp = 0
	print_debug("level-up!", level)
	next_exp_goal = get_exp_goal()
	

func get_exp_goal():
	return 2 * level


func on_enemy_killed():
	add_exp(1)
