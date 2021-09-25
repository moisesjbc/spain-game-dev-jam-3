extends Node


var tutorial
var ghost_scene = load("res://gameplay/ghost/ghost.tscn")
var ghost

func on_init(info_text: RichTextLabel):
	info_text.bbcode_text = '[center]¡Bu!\nMejor quedarse detrás de la torreta\nPulsa [ENTER] para continuar[/center]'
	ghost = ghost_scene.instance()
	var player = tutorial.get_node('main').get_node('player')
	ghost.global_position = player.global_position
	ghost.global_position.x += 300
	ghost.name = 'ghost'
	tutorial.get_node('main').add_child(ghost)
	ghost.movement_speed = 100
	ghost.set_physics_process(false)


func on_event(event):
	if event is InputEventKey and not event.pressed and event.scancode == KEY_ENTER:
		ghost.set_physics_process(true)
		tutorial.next_state()
