extends Area2D
@export var target = Vector2(0,0)
@export var speed = 100
var direction = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	print(direction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta
	
