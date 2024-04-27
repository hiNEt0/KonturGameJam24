class_name InventoryManager
extends Node


var player: Node2D


func assign_player(player_node):
	player = player_node


func add_spell(spell, slot):
	player.add_child(spell)
	spell.assign_player(player)
	spell.key = slot
