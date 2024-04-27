class_name Player
extends CharacterBody2D

@export var speed = 100 # How fast the player will move (pixels/sec).
@export var hp = 100
@export var damage_cooldown = 1.0
@onready var aim = $aim
@onready var sprite = $sprites
@onready var direction = Vector2(1, 0)
@onready var last_direction = direction

func get_damage(damage):
	if damage_cooldown >= 1.0:
		damage_cooldown = 0.0
		hp -= damage
		if hp <= 0:
			game_over()

func game_over():
	print_debug('game over')

func _physics_process(delta):
	velocity = Vector2.ZERO # The player's movement vector.
	if damage_cooldown < 1.0:
		damage_cooldown += delta
		print_debug(damage_cooldown)
		
	if Input.is_action_pressed("move_right"):
		sprite.play("wiz_right")
		velocity.x += 1
		aim.position.x = 100
	if Input.is_action_pressed("move_left"):
		sprite.play("wiz_left")
		velocity.x -= 1
		aim.position.x = -100
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		aim.position.y = 100
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		aim.position.y = -100
	if not Input.is_anything_pressed():
		sprite.play("idle")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions
	#if direction:
		#velocity.x = direction * speed
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed)
		
	direction = get_direction()
	move_and_collide(velocity.normalized() * speed * delta)
	
func get_direction():
	var directing_velocity = velocity
	if directing_velocity.x > 0:
		directing_velocity.x = 1
	if directing_velocity.x < 0:
		directing_velocity.x = -1
	if directing_velocity.y > 0:
		directing_velocity.y = 1
	if directing_velocity.y < 0:
		directing_velocity.y = -1
	
	if directing_velocity == Vector2(0, 0):
		directing_velocity = last_direction
	
	last_direction = directing_velocity
	return directing_velocity
