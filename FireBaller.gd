extends Node2D
class_name fire_baller

@export var cooldown = 1
@onready var timer = cooldown
@onready var missile = load("res://fire_ball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer < 0:
		timer = cooldown
		var current_missile = missile.instantiate()
		current_missile.position = get_parent().position
		current_missile.direction = (get_parent().get_target_enemy() - get_parent().position).normalized()
		get_tree().get_root().add_child(current_missile)
	else:
		timer -= delta
		
	
func get_target():
	return Vector2(100, 0)
