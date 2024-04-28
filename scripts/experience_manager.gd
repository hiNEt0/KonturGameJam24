class_name ExperienceManager
extends Node

@onready var exp = 0
@onready var level = 1
@onready var next_exp_goal = 3

@onready var spell_scenes = [
	load("res://scenes/exploding_fire/exploding_fire_caster.tscn"),
	load("res://scenes/shotgun/shotgun_caster.tscn"),
	load("res://scenes/slowness/slowness_caster.tscn"),
	load("res://scenes/drop_dash/drop_dash_caster.tscn"),
	load("res://scenes/fire_wall/fire_wall_caster.tscn"),
]

var inv_manager: InventoryManager
var hud: HUD

var spell_1_id: int
var spell_2_id: int
var spell_3_id: int
var chosen_spell_id: int
var chosen_option_id: int


func add_exp(amount):
	exp += amount
	if exp >= next_exp_goal:
		level_up()


func level_up():
	level += 1
	exp = 0
	next_exp_goal = get_exp_goal()
	offer_reward()


func get_exp_goal():
	return 3 * level


func on_enemy_killed():
	add_exp(1)


func assign_nodes(inv_man_node, hud_node):
	inv_manager = inv_man_node
	hud = hud_node


func offer_reward():
	var ids = []
	for i in range(len(spell_scenes)):
		ids.append(i)
	spell_1_id = ids.pop_at(randi_range(0, len(ids) - 1))
	spell_2_id = ids.pop_at(randi_range(0, len(ids) - 1))
	spell_3_id = ids.pop_at(randi_range(0, len(ids) - 1))
	hud.format_options(spell_scenes[spell_1_id], spell_scenes[spell_2_id], spell_scenes[spell_3_id])
	hud.show_levelup_panel()


func _on_option_1_toggled(toggled_on):
	if toggled_on:
		chosen_spell_id = spell_1_id
		chosen_option_id = 1


func _on_option_2_toggled(toggled_on):
	if toggled_on:
		chosen_spell_id = spell_2_id
		chosen_option_id = 2


func _on_option_3_toggled(toggled_on):
	if toggled_on:
		chosen_spell_id = spell_3_id
		chosen_option_id = 3
