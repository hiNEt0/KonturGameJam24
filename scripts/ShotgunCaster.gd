class_name ShotgunCaster
extends Node2D

@export var display_name = "Дробящий призыв"
@export var display_icon: Texture2D

@export var cooldown = 1
@export var count = 5

@onready var timer = 0.5
@onready var can_cast = false
@onready var spell_scene = load("res://scenes/shotgun/shotgun_spell.tscn")

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
	for i in range(count):
		var new_spell = spell_scene.instantiate()
		new_spell.setup(player.position, Vector2(player.direction.x + randf_range(-PI / 8, PI / 8), player.direction.y + randf_range(-PI / 8, PI / 8)))
		get_tree().get_root().add_child(new_spell)
	
	timer = cooldown
	can_cast = false
