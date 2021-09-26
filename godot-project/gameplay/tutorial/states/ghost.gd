extends Node


var tutorial
var ghost_scene = load("res://gameplay/ghost/ghost.tscn")
var player
var ghost

func on_init(info_text: RichTextLabel):
	info_text.set_text('¡Bu!\nMejor quedarse detrás de la torreta\nPulsa [ENTER] para continuar\n')
	ghost = ghost_scene.instance()
	player = tutorial.get_node('main').get_node('player')
	player.set_physics_process(false)
	ghost.name = 'ghost'
	tutorial.get_node('main').add_child(ghost)
	ghost.global_position = player.global_position
	ghost.global_position.x += 300
	ghost.movement_speed = 100
	ghost.set_physics_process(false)


func on_event(event):
	if event is InputEventKey and not event.pressed and event.scancode == KEY_ENTER:
		player.set_physics_process(true)
		ghost.set_physics_process(true)
		tutorial.next_state()
