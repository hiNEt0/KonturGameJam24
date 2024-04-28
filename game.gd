class_name Game
extends Node

@export var enemy_scene: PackedScene
@export var time_to_spawn: float

@onready var enemy_speed = 1.0
@onready var min_time_to_spawn = 0.5
@onready var spawn_timer = -5.0
@onready var player = $"Player2"
@onready var exp_manager = $"ExperienceManager"
@onready var event_manager = $"EventManager"
@onready var inv_manager = $"InventoryManager"
@onready var music = $"AudioStreamPlayer2D"
@onready var sfx = $"dementiaplayer"
@onready var hud = $"HUD"


func _ready():
	hud.set_process_mode(PROCESS_MODE_ALWAYS)
	exp_manager.assign_nodes(inv_manager, hud)
	inv_manager.assign_player(player)
	music.play()
	event_manager.assign_nodes(inv_manager, sfx)
	hud.assign_nodes(player, exp_manager, inv_manager)


func _process(delta):
	spawn_timer += delta
	if spawn_timer >= time_to_spawn:
		spawn_enemy()
		spawn_timer = 0.0
		time_to_spawn = max(min_time_to_spawn, time_to_spawn - 0.04)
		enemy_speed += 0.05


func spawn_enemy():
	var screen_size = player.get_viewport_rect().size
	var random_x = randf_range(-screen_size.x, screen_size.x)
	var random_y = randf_range(-screen_size.y, screen_size.y)
	
	var new_enemy = enemy_scene.instantiate()
	new_enemy.initialize(player, exp_manager, Vector2(random_x, random_y), enemy_speed)
	add_child(new_enemy)
