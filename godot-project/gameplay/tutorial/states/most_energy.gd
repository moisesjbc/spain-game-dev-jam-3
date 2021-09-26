extends Node


var tutorial


func on_init(info_text: RichTextLabel):
	info_text.set_text('¡Perfecto!\nCuanto más energía tenga la torreta, más rápido disparará.\nPulsa [ENTER] para continuar.')


func on_event(event):
	tutorial.next_state_on_enter(event)
