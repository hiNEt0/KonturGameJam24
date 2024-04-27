class_name Enemy
extends RigidBody2D

var player_node : Node2D
@export var speed = 1.0
@export var hp = 100

func initialize(player, new_position):
	player_node = player
	position = new_position


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	linear_velocity = Vector2(player_node.position - position).normalized() * delta * 1000 * speed


func _on_body_entered(body):
	player_node.get_damage(20)
	print_debug(player_node.hp)
