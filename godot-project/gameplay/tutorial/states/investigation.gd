extends Node

var tutorial


func on_init(info_text: RichTextLabel):
	info_text.set_text('¿Qué investigación, te preguntas?\nPulsa [ENTER] para continuar.')


func on_event(event):
	tutorial.next_state_on_enter(event)
