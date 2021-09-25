extends Node


var tutorial
var cable_roll


func on_init(info_text: RichTextLabel):
	info_text.bbcode_text = '[center]Parece que no tiene energía para funcionar...\nAcércate hasta que veas un botón de un enchufe y clica en él[/center]'
	cable_roll = tutorial.get_node('main').get_node('player').get_node('cable_roll')
	cable_roll.stop_throwing()
	cable_roll.connect('connection_started', self, '_on_connection_started')


func _on_connection_started(origin):
	if origin.name == 'investigation_centre':
		cable_roll.disconnect('connection_started', self, '_on_connection_started')
		tutorial.next_state()
	else:
		cable_roll.stop_throwing()
