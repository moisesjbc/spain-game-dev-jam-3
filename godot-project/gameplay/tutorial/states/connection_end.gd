extends Node


var tutorial
var cable_roll
var investigation_centre


func on_init(info_text: RichTextLabel):
	info_text.bbcode_text = '[center]¡Perfecto! Ahora busca algo que parece un panel solar (recuerda, no voy a por el premio de Arte) y pulsa en el botón para conectarlo[/center]'
	cable_roll = tutorial.get_node('main').get_node('player').get_node('cable_roll')
	investigation_centre = tutorial.get_node('main').get_node('investigation_centre')
	cable_roll.connect('connection_ended', self, '_on_connection_ended')


func _on_connection_ended(target):
	if 'generators' in target.get_groups():
		cable_roll.disconnect('connection_ended', self, '_on_connection_ended')
		tutorial.next_state()
	else:
		cable_roll.start_throwing(investigation_centre)
