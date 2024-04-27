extends Area2D
@export var target = Vector2(0,0)
@export var speed = 150
var direction = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta
	

func _on_body_entered(body):
	if body is Enemy:
		body.get_damage(25)
		queue_free()
