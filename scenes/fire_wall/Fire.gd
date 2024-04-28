extends Node2D
@export var damage_delay = 1.0
var timer = damage_delay
var lifetime = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lifetime < 0:
		queue_free()
	lifetime -= delta
	if timer < 0:
		timer = damage_delay
		get_parent().get_damage(50)
	timer -= delta
