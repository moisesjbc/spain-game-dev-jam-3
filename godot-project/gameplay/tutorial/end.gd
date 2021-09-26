extends Node


var tutorial


func on_init(info_text: RichTextLabel):
	info_text.set_text('Pues tampoco creo que quede bien en la categoría de sonido...\nPulsa [ENTER] para terminar el tutorial.')


func on_event(event):
	tutorial.next_state_on_enter(event)
