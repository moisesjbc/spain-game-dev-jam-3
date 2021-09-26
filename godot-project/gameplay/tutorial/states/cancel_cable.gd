extends Node


var tutorial


func on_init(info_text: RichTextLabel):
	info_text.set_text('Si estás tirando cable puedes cancelar la acción pulsando el botón derecho del ratón.\nPulsa [ENTER] para continuar.')


func on_event(event):
	tutorial.next_state_on_enter(event)
