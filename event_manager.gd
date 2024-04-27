extends Node2D
var player_node : Node2D
var time = 10
@onready var timer = time

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

func execute_random_event():
	var events = {"test": test_event,
	"rl": forgot_movement_rl,
	"td": forgot_movement_td}
	var rand_num = randi() % len(events.keys())
	events[events.keys()[rand_num]].call()
	
func test_event():
	print('dementia is coming')
	
func forgot_movement_rl():
	print('rl')
	player_node.movement_modifier.x = -1
	
func forgot_movement_td():
	print('td')
	player_node.movement_modifier.y = -1
