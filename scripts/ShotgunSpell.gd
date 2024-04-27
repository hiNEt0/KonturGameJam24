extends Area2D

@onready var speed = 200
@export var damage = 100
@export var max_lifetime = 0.5
@onready var lifetime = 0.0

var start_position: Vector2
var direction: Vector2

func _process(delta):
	position += direction.normalized() * speed * delta
		
	lifetime += delta
	if lifetime >= max_lifetime:
		queue_free()

func _on_body_entered(body):
	if body is Enemy:
		body.get_damage(damage)
		lifetime = max_lifetime

func setup(player_position, player_direction):
	position = player_position
	start_position = player_position
	direction = player_direction
	
