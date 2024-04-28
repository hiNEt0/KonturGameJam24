class_name SlownessSpell
extends Area2D


@export var damage = 2
@export var max_lifetime = 0.7
@onready var lifetime = 0.0
@onready var speed = 0

var start_position: Vector2

var slowned_enemies = []

func _process(delta):
	lifetime += delta
	if lifetime >= max_lifetime:
		for i in slowned_enemies:
			if i != null:
				i.speed *= 10
		queue_free()


func _on_body_entered(body):
	if body is Enemy:
		slowned_enemies.append(body)
		body.speed *= 0.1


func setup(player_position):
	position = player_position
	start_position = player_position
	
