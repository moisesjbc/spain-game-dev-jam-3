extends Node


var tutorial
var ghost_scene = load("res://gameplay/ghost/ghost.tscn")
var ghost
var player


func on_init(info_text: RichTextLabel):
	info_text.set_text('Manten al fantasma cerca de la torreta (¡sin tocarlo!) hasta que la torreta se encargue de él.')
	ghost = tutorial.get_node('main').get_node('ghost')
	player = tutorial.get_node('main').get_node('player')
	ghost.connect('ghost_hit_by_bullet', self, '_ghost_hit_by_bullet')
	player.connect('player_hit', self, 'another_ghost')


func _ghost_hit_by_bullet():
	ghost.disconnect('ghost_hit_by_bullet', self, '_ghost_hit_by_bullet')
	player.disconnect('player_hit', self, 'another_ghost')
	tutorial.next_state()


func another_ghost(_player_hp):
	ghost = ghost_scene.instance()
	ghost.global_position = player.global_position
	ghost.global_position.x += 300
	ghost.name = 'ghost'
	ghost.connect('ghost_hit_by_bullet', self, '_ghost_hit_by_bullet')
	tutorial.get_node('main').add_child(ghost)
	ghost.movement_speed = 100
