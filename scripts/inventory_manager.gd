class_name InventoryManager
extends Node

@onready var spells = {
	KEY_J: null,
	KEY_K: null,
	KEY_L: null,
}

var player: Node2D

@onready var icon1 = $"../HUD/Control/SpellIcon1" as TextureRect
@onready var icon2 = $"../HUD/Control/SpellIcon2" as TextureRect
@onready var icon3 = $"../HUD/Control/SpellIcon3" as TextureRect


func assign_player(player_node):
	player = player_node


func set_spell(spell_slot, spell_scene):
	if spells[spell_slot]:
		remove_spell(spell_slot)
	add_spell(spell_slot, spell_scene)


func add_spell(spell_slot, spell_scene):
	var new_spell_caster = spell_scene.instantiate()
	new_spell_caster.assign_key(spell_slot)
	new_spell_caster.assign_player(player)
	player.add_child(new_spell_caster)
	spells[spell_slot] = new_spell_caster
	
	match spell_slot:
		KEY_J: icon1.texture = new_spell_caster.display_icon
		KEY_K: icon2.texture = new_spell_caster.display_icon
		KEY_L: icon3.texture = new_spell_caster.display_icon


func remove_spell(spell_slot):
	player.remove_child(spells[spell_slot])
	spells[spell_slot] = null
	print_debug("remove at", spell_slot)
	
	match spell_slot:
		KEY_J: icon1.texture = null
		KEY_K: icon2.texture = null
		KEY_L: icon3.texture = null
