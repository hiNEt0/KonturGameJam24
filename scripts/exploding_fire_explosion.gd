class_name ExplodingFireExplosion
extends Area2D

@onready var explosion_shape = $ExplosionShape
@onready var timer = 0.5;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer > 0:
		timer -= delta
	else:
		print_debug("died")
		queue_free()

func setup(explosion_position):
	position = explosion_position
