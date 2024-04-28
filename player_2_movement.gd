class_name Player
extends CharacterBody2D

@export var speed = 100 # How fast the player will move (pixels/sec).
@export var hp = 100
@export var max_hp = 100
@export var damage_cooldown = 1.0
@export var dash_cooldown = 1.0
@export var dash_force = 60
@onready var aim = $aim
@onready var sprite = $sprites
@onready var direction = Vector2(1, 0)
@onready var last_direction = direction
@onready var can_dash = false
var movement_modifier = Vector2(1, 1)
var dash = 1
var isOver = false
var overTime = 3


func get_damage(damage):
	if !isOver:
		if damage_cooldown >= 1.0:
			damage_cooldown = 0.0
			hp -= damage
			if hp <= 0:
				game_over()

func game_over():
	var hud = get_parent().get_node("HUD/Control/GameOverText")
	hud.visible = true
	isOver = true
	get_node("FireBaller").queue_free()
	
	
func get_target_enemy():
	var enemies = get_tree().get_nodes_in_group("enemies") # Получаем список всех узлов в группе "enemies"
	var closest_enemy = null
	var closest_distance = INF

	for enemy in enemies:
		if enemy is Enemy:
			var distance = global_position.distance_to(enemy.global_position) # Рассчитываем расстояние между текущим узлом и врагом
			if distance < closest_distance:
				closest_enemy = enemy
				closest_distance = distance

	return Vector2(closest_enemy.position)

func do_dash():
	can_dash = true

func _physics_process(delta):
	if isOver:
		overTime -= delta
	if overTime < 0:
		get_tree().quit()
	velocity = Vector2.ZERO # The player's movement vector.
	if damage_cooldown < 1.0:
		damage_cooldown += delta
	if dash_cooldown < 1.0:
		dash_cooldown += delta
		
	if can_dash:
		dash = dash_force
		dash_cooldown = 0.0
		can_dash = false
	else:
		dash = 1
		
	if Input.is_action_pressed("move_right"):
		sprite.play("wiz_move")
		velocity.x += 1
		aim.position.x = 100
	if Input.is_action_pressed("move_left"):
		sprite.play("wiz_move")
		velocity.x -= 1
		aim.position.x = -100
	if Input.is_action_pressed("move_down"):
		sprite.play("wiz_move")
		velocity.y += 1
		aim.position.y = 100
	if Input.is_action_pressed("move_up"):
		sprite.play("wiz_move")
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
	velocity.x *= movement_modifier.x
	velocity.y *= movement_modifier.y
	if velocity.x != 0:
		$sprites.flip_h = velocity.x < 0
	if isOver:
		velocity = Vector2(0, 0)
	move_and_collide(velocity.normalized() * speed * delta * dash)
	
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
