extends Node


var tutorial
var connections


func on_init(info_text: RichTextLabel):
	info_text.bbcode_text = '[center]Pero antes de que los veas... quizás te interese buscar una torreta y conectarla a la red[/center]'
	connections = tutorial.get_node('main').get_node('connections')
	connections.connect('connection_added', self, '_on_connection_added')


func _on_connection_added(connection):
	if ('turrets' in connection[0].get_groups() and connection[0].energy > 0) or \
	   ('turrets' in connection[1].get_groups() and connection[1].energy > 0):
		connections.disconnect('connection_added', self, '_on_connection_added')
		tutorial.next_state()
