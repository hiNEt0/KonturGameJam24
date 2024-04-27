extends Node2D
class_name fire_baller

@export var cooldown = 1
@onready var timer = cooldown
@onready var missile = load("res://fire_ball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer < 0:
		timer = cooldown
		var current_missile = missile.instantiate()
		current_missile.position = get_parent().position
		current_missile.direction = (get_target_enemy() - get_parent().position).normalized()
		get_tree().get_root().add_child(current_missile)
	else:
		timer -= delta
		

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
	
func _on_RayCast2D_body_entered(body):
	if body is Enemy:
		print("Найден ближайший враг:", body)
	
func get_target():
	return Vector2(100, 0)
