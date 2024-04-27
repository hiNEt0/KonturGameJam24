class_name ExplodingFireSpell
extends Area2D

@onready var speed = 0

@export var speed_curve: Curve
@export var damage = 2

@export var max_lifetime = 0.7
@onready var lifetime = 0.0

@onready var explosion_scene = load("res://scenes/exploding_fire/exploding_fire_explosion.tscn")

var start_position: Vector2
var direction: Vector2


func _process(delta):
	position += direction.normalized() * speed * delta
	speed = speed_curve.sample(lifetime / max_lifetime)
		
	lifetime += delta
	if lifetime >= max_lifetime:
		explode()
		queue_free()


func _on_body_entered(body):
	if body is Enemy:
		lifetime = max_lifetime


func setup(player_position, player_direction):
	position = player_position
	start_position = player_position
	direction = player_direction


func explode():
	var new_explosion = explosion_scene.instantiate()
	new_explosion.setup(position)
	get_tree().get_root().add_child(new_explosion)
	
