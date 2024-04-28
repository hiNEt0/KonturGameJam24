extends Node2D
var player_node : Node2D
var time = 10
@onready var timer = time

var inv_manager: InventoryManager
var sfx: AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	player_node = get_parent().get_node("Player2")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer < 0:
		timer = time
		execute_random_event()
	else:
		timer -= delta


func assign_nodes(inv_man_node, sfx_node):
	inv_manager = inv_man_node
	sfx = sfx_node


func execute_random_event():
	sfx.play()
	var roll = randi_range(0, 100)
	if 0 <= roll and roll < 10:
		player_node.movement_modifier.x *= -1
	if 10 <= roll and roll < 20:
		player_node.movement_modifier.y *= -1
	if 20 <= roll and roll < 50:
		inv_manager.remove_spell([KEY_J, KEY_K, KEY_L][randi_range(0, 2)])
