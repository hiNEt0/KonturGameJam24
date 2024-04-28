class_name Enemy
extends CharacterBody2D

var player_node: Node2D
var exp_manager_node: ExperienceManager

@export var speed = 1.0
@export var hp = 100
@export var attack_cooldown = 1.0
@export var exp_worth = 1

signal on_killed

func initialize(player, exp_manager, new_position):
	player_node = player
	exp_manager_node = exp_manager
	connect("on_killed", exp_manager_node.on_enemy_killed)
	position = new_position
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")

func get_damage(damage):
	hp -= damage
	if hp <= 0:
		on_killed.emit()
		queue_free()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if attack_cooldown < 1.0:
		attack_cooldown += delta
		
	$AnimatedSprite2D.flip_h = velocity.x < 0
		
	velocity = Vector2(player_node.position - position).normalized() * 50
	var collisions = move_and_collide(velocity * delta * speed)
	if collisions:
		var collider = collisions.get_collider()
		if collider is Player and attack_cooldown >= 1.0:
			attack_cooldown = 0.0
			on_hit_player()

func on_hit_player():
	player_node.get_damage(20)

