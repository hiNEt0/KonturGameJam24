class_name ExplodingFireCaster
extends Node2D

@export var cooldown = 1

@onready var timer = cooldown
@onready var can_cast = false
@onready var spell_scene = load("res://scenes/exploding_fire/exploding_fire_spell.tscn")

var player: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tick_cooldown(delta)
	if can_cast and Input.is_key_pressed(KEY_J):
		cast()


func assign_player(player_node):
	player = player_node


func tick_cooldown(delta):
	if timer > 0:
		timer -= delta
	else:
		can_cast = true

func cast():
	var new_spell = spell_scene.instantiate()
	new_spell.setup(player.position, player.direction)
	get_tree().get_root().add_child(new_spell)
	
	print_debug("casted ", position)
	
	timer = cooldown
	can_cast = false
