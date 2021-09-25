extends Node


var tutorial


func on_init(info_text: RichTextLabel):
	info_text.bbcode_text = '[center]Si estás tirando cable puedes cancelar la acción pulsando el botón derecho del ratón.\n Pulsa [ENTER] para continuar[/center]'


func on_event(event):
	tutorial.next_state_on_enter(event)
