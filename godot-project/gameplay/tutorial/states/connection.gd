extends Node


var tutorial
var investigation_centre


func on_init(info_text: RichTextLabel):
	info_text.set_text('Ok, el recuadro naranja se supone que es un centro de investigación (sobra decir que no aspiro a ganar el apartado de arte).\nPulsa [ENTER] para continuar.')
	investigation_centre = tutorial.get_node('main').get_node('investigation_centre')


func on_event(event):
	tutorial.next_state_on_enter(event)
