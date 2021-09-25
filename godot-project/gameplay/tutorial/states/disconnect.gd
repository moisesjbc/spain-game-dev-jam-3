extends Node


var tutorial
var connections


func on_init(info_text: RichTextLabel):
	info_text.bbcode_text = '[center]Al acercarte a cualquier cable aparecerá un botón para desconectarlo.\n¡Haz la prueba y desconéctalo![/center]'
	connections = tutorial.get_node('main').get_node('connections')
	connections.connect('connection_removed', self, '_on_connection_removed')

func _on_connection_removed():
	tutorial.next_state()
