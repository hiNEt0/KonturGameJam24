extends CharacterBody2D

@export var speed = 100 # How fast the player will move (pixels/sec).
@export var hp = 100
@onready var aim = $aim
@onready var sprite = $sprites

# Get the gravity from the project settings to be synced with RigidBody nodes.

func get_damage(damage):
	hp -= damage
	if hp <= 0:
		game_over()

func game_over():
	print_debug('game over')

func _physics_process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
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

	move_and_collide(velocity.normalized() * speed * delta)
	

