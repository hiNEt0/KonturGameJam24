class_name FireWallCaster
extends Node2D

@export var display_name = "Огненный столп"
@export var display_icon: Texture2D

@export var cooldown = 1
@export var offset = 100

@onready var timer = cooldown
@onready var can_cast = false
@onready var spell_scene = load("res://scenes/fire_wall/fire_wall_focus.tscn")
@onready var key: Key


var player: Node2D


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
	new_spell.setup(player.position, player.direction.normalized() * offset)
	get_tree().get_root().add_child(new_spell)
	
	timer = cooldown
	can_cast = false
