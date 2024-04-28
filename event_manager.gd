extends Node2D

@export var forgor_time = 2
@onready var forgor_timer = forgor_time

var player_node : Node2D
var time = 10
@onready var timer = 20

var inv_manager: InventoryManager
var sfx: AudioStreamPlayer2D

@onready var forgor_texture = $"../HUD/Control/ForgorTexture"

# Called when the node enters the scene tree for the first time.
func _ready():
	player_node = get_parent().get_node("Player2")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if forgor_timer < 0:
		forgor_texture.visible = false
	else:
		forgor_timer -= delta
		
	if timer < 0:
		timer = time
		execute_random_event()
	else:
		timer -= delta


func assign_nodes(inv_man_node, sfx_node):
	inv_manager = inv_man_node
	sfx = sfx_node


func execute_random_event():
	forgor_timer = forgor_time
	forgor_texture.visible = true
	sfx.play()
	var roll = randi_range(0, 100)
	if 0 <= roll and roll < 5:
		player_node.movement_modifier.x *= -1
		forgor_texture.texture = load("res://resources/sprites/forgor/forgor_lr.png")
	if 5 <= roll and roll < 10:
		player_node.movement_modifier.y *= -1
		forgor_texture.texture = load("res://resources/sprites/forgor/forgor_td.png")
	if 10 <= roll and roll < 30:
		inv_manager.remove_spell(KEY_J)
		forgor_texture.texture = load("res://resources/sprites/forgor/forgor_j.png")
	if 30 <= roll and roll < 50:
		inv_manager.remove_spell(KEY_K)
		forgor_texture.texture = load("res://resources/sprites/forgor/forgor_k.png")
	if 50 <= roll and roll < 70:
		inv_manager.remove_spell(KEY_L)
		forgor_texture.texture = load("res://resources/sprites/forgor/forgor_l.png")
	if 70 <= roll and roll <= 100:
		forgor_texture.texture = null
