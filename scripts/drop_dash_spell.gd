class_name DropDashSpell
extends Area2D

@onready var timer = 1.0


func _process(delta):
	if timer > 0:
		timer -= delta
	else:
		queue_free()


func setup(explosion_position):
	position = explosion_position


func _on_body_entered(body):
	if body is Enemy:
		body.get_damage(100)
