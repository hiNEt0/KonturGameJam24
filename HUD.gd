class_name HUD
extends CanvasLayer

@onready var hp_bar = $"Control/HealthBar"
@onready var exp_bar = $"Control/ExpBar"
@onready var lvl_label = $"Control/Level"

@onready var levelup_panel = $"Control/LevelupPanel"
@onready var option1 = $"Control/LevelupPanel/Option1" as Button
@onready var option2 = $"Control/LevelupPanel/Option2" as Button
@onready var option3 = $"Control/LevelupPanel/Option3" as Button

@onready var optionIcon1 = $"Control/LevelupPanel/OptionIcon1"
@onready var optionIcon2 = $"Control/LevelupPanel/OptionIcon2"
@onready var optionIcon3 = $"Control/LevelupPanel/OptionIcon3"

@onready var optionLabel1 = $"Control/LevelupPanel/OptionLabel1"
@onready var optionLabel2 = $"Control/LevelupPanel/OptionLabel2"
@onready var optionLabel3 = $"Control/LevelupPanel/OptionLabel3"

@onready var levelup_time = false

@onready var levelup_select_cooldown = 0.2
@onready var levelup_select_timer = 0

var player: Node2D
var exp_manager: ExperienceManager
var inv_manager: InventoryManager


func assign_nodes(player_node, exp_man_node, inv_man_node):
	player = player_node
	exp_manager = exp_man_node
	inv_manager = inv_man_node


func _process(delta):
	update_hp_bar()
	update_exp_bar()
	if levelup_time:
		if levelup_select_timer > 0:
			levelup_select_timer -= delta
		else:
			levelup_controls()

func update_hp_bar():
	hp_bar.max_value = player.max_hp
	hp_bar.value = player.hp


func update_exp_bar():
	exp_bar.max_value = exp_manager.next_exp_goal
	exp_bar.value = exp_manager.exp
	lvl_label.text = var_to_str(exp_manager.level)


func format_options(op1, op2, op3):
	var ins1 = op1.instantiate()
	var ins2 = op2.instantiate()
	var ins3 = op3.instantiate()
	
	optionIcon1.texture = ins1.display_icon
	optionIcon2.texture = ins2.display_icon
	optionIcon3.texture = ins3.display_icon

	optionLabel1.text = ins1.display_name
	optionLabel2.text = ins2.display_name
	optionLabel3.text = ins3.display_name


func show_levelup_panel():
	levelup_panel.visible = true
	levelup_time = true
	option1.button_pressed = true
	
	get_tree().paused = true


func hide_levelup_panel():
	levelup_panel.visible = false
	levelup_time = false
	match exp_manager.chosen_option_id:
		1: option1.button_pressed = false
		2: option2.button_pressed = false
		3: option3.button_pressed = false
	
	get_tree().paused = false


func levelup_controls():
	if Input.is_key_pressed(KEY_J):
		inv_manager.set_spell(KEY_J, exp_manager.spell_scenes[exp_manager.chosen_spell_id])
		levelup_select_timer = levelup_select_cooldown
		hide_levelup_panel()
	if Input.is_key_pressed(KEY_K):
		inv_manager.set_spell(KEY_K, exp_manager.spell_scenes[exp_manager.chosen_spell_id])
		levelup_select_timer = levelup_select_cooldown
		hide_levelup_panel()
	if Input.is_key_pressed(KEY_L):
		inv_manager.set_spell(KEY_L, exp_manager.spell_scenes[exp_manager.chosen_spell_id])
		levelup_select_timer = levelup_select_cooldown
		hide_levelup_panel()
	
	match exp_manager.chosen_option_id:
		1:
			if Input.is_key_pressed(KEY_W):
				option1.button_pressed = false
				option3.button_pressed = true
				levelup_select_timer = levelup_select_cooldown
			if Input.is_key_pressed(KEY_S):
				option1.button_pressed = false
				option2.button_pressed = true
				levelup_select_timer = levelup_select_cooldown
		2:
			if Input.is_key_pressed(KEY_W):
				option2.button_pressed = false
				option1.button_pressed = true
				levelup_select_timer = levelup_select_cooldown
			if Input.is_key_pressed(KEY_S):
				option2.button_pressed = false
				option3.button_pressed = true
				levelup_select_timer = levelup_select_cooldown
		3:
			if Input.is_key_pressed(KEY_W):
				option3.button_pressed = false
				option2.button_pressed = true
				levelup_select_timer = levelup_select_cooldown
			if Input.is_key_pressed(KEY_S):
				option3.button_pressed = false
				option1.button_pressed = true
				levelup_select_timer = levelup_select_cooldown
