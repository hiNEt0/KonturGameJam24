extends Area2D
@export var target = Vector2(0,0)
@export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position.move_toward((target - self.position).normalized(), speed * delta)
