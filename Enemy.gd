class_name Enemy
extends CharacterBody2D

var player_node : Node2D
@export var speed = 1.0
@export var hp = 100
@export var attack_cooldown = 1.0

func initialize(player, new_position):
	player_node = player
	position = new_position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_damage(damage):
	hp -= damage
	if hp <= 0:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if attack_cooldown < 1.0:
		attack_cooldown += delta
		
	velocity = Vector2(player_node.position - position).normalized() * 50
	var collisions = move_and_collide(velocity * delta * speed)
	if collisions:
		var collider = collisions.get_collider()
		if collider is Player and attack_cooldown >= 1.0:
			attack_cooldown = 0.0
			on_hit_player()

func on_hit_player():
	player_node.get_damage(20)
	print_debug(player_node.hp)

