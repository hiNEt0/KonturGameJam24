class_name InventoryManager
extends Node

@onready var spells = {
	KEY_J: null,
	KEY_K: null,
	KEY_L: null,
}

var player: Node2D


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


func remove_spell(spell_slot):
	player.remove_child(spells[spell_slot])
	spells[spell_slot] = null
	print_debug("remove at", spell_slot)
