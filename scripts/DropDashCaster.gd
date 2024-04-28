class_name DropDashCaster
extends Node2D

@export var cooldown = 3

@onready var timer = cooldown
@onready var can_cast = false
@onready var spell_scene = load("res://scenes/drop_dash/drop_dash_spell.tscn")

var player: Node2D
var key: Key

func _process(delta):
	tick_cooldown(delta)
	if can_cast and Input.is_key_pressed(key):
		cast()

func assign_player(player_node):
	player = player_node

func assign_key(keycode):
	key = keycode

func tick_cooldown(delta):
	if timer > 0:
		timer -= delta
	else:
		can_cast = true

func cast():
	var new_spell = spell_scene.instantiate()
	new_spell.setup(player.position)
	get_tree().get_root().add_child(new_spell)
	
	player.do_dash()
	
	timer = cooldown
	can_cast = false
