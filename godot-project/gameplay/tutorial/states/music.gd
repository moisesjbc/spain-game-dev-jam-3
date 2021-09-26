extends Node


var tutorial


func on_init(info_text: RichTextLabel):
	info_text.set_text('¡Enhorabuena por llegar hasta aquí!. Disfruta de unos segundos de esta canción épica como recompensa.\nPulsa [ENTER] para continuar.')


func on_event(event):
	tutorial.next_state_on_enter(event)
