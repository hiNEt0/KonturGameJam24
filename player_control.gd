extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
@onready var aim = $aim

func _process(delta):
	aim.position.x = 0
	aim.position.y = 0
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		aim.position.x = 100
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		aim.position.x = -100
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		aim.position.y = 100
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		aim.position.y = -100

	#if velocity.length() > 0:
		#velocity = velocity.normalized() * speed
		#$AnimatedSprite2D.play()
	#else:"res://gratis-png-johnny-knoxville-jackass-presenta-abuelo-malo-irving-zisman-pelicula-anciano.png"
		#$AnimatedSprite2D.stop()
	
	position += velocity.normalized() * delta * speed
	
