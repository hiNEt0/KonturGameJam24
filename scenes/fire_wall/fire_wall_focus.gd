extends Area2D
@onready var lifetime = 5.0
@onready var burning = []
@onready var spell_scene = load("res://scenes/fire_wall/fire.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_body_entered(body):
	if body is Enemy:
		#lifetime = max_lifetime
		var fire = spell_scene.instantiate()
		body.add_child(fire)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	lifetime -= delta
	if lifetime < 0:
		queue_free()
	

func setup(player_position, player_direction):
	position = player_position + player_direction
	

