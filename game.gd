class_name Game
extends Node

@export var enemy_scene: PackedScene
@export var time_to_spawn: float
@onready var spawn_timer = 0.0
@onready var player = $"Player2"
@onready var exp_manager = $"ExperienceManager"
@onready var event_manager = $"EventManager"
@onready var inv_manager = $"InventoryManager"
@onready var music = $"AudioStreamPlayer2D"
@onready var sfx = $"dementiaplayer"

# Called when the node enters the scene tree for the first time
func _ready():
	spawn_enemy()
	exp_manager.assign_inv_manager(inv_manager)
	inv_manager.assign_player(player)
	music.play()
	event_manager.assign_player(sfx)
	$Player2/SlownessCaster.assign_player(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_timer += delta
	if spawn_timer >= time_to_spawn:
		spawn_enemy()
		spawn_timer = 0.0

func spawn_enemy():
	var screen_size = player.get_viewport_rect().size
	var random_x = randf_range(-screen_size.x, screen_size.x)
	var random_y = randf_range(-screen_size.y, screen_size.y)
	
	var new_enemy = enemy_scene.instantiate()
	new_enemy.initialize(player, exp_manager, Vector2(random_x, random_y))
	add_child(new_enemy)
