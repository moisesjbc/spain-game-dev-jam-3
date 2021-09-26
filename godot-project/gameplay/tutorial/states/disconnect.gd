extends Node


var tutorial
var connections


func on_init(info_text: RichTextLabel):
	info_text.set_text('Al acercarte a cualquier cable aparecerá un botón para desconectarlo.\n¡Haz la prueba y desconéctalo!')
	connections = tutorial.get_node('main').get_node('connections')
	connections.connect('connection_removed', self, '_on_connection_removed')

func _on_connection_removed():
	connections.disconnect('connection_removed', self, '_on_connection_removed')
	tutorial.next_state()
