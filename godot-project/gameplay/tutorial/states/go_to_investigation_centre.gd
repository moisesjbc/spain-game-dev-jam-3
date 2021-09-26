extends Node


var tutorial
var investigation_centre
var player


func on_init(info_text: RichTextLabel):
	info_text.set_text('¡Muy bien! Ahora busca por el mapa un recuadro naranja.')
	investigation_centre = tutorial.get_node('main').get_node('investigation_centre')
	player = tutorial.get_node('main').get_node('player')


func on_event(event):
	if event is InputEventKey and player.global_position.distance_to(investigation_centre.global_position) < 350:
		tutorial.next_state()
