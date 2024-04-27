class_name ExplodingFireExplosion
extends Area2D

@onready var explosion_shape = $ExplosionShape
@onready var timer = 0.5
@export var explosion_time_threshold = 0.4


func _process(delta):
	if timer > 0:
		timer -= delta
	else:
		queue_free()


func setup(explosion_position):
	position = explosion_position


func _on_body_entered(body):
	if timer > explosion_time_threshold and body is Enemy:
		body.get_damage(100)
