extends Node


var tutorial


func on_init(info_text: RichTextLabel):
	info_text.bbcode_text = '[center]¡Perfecto!\nCuanto más energía tenga la torreta, más rápido disparará. Pulsa [ENTER] para continuar[/center]'


func on_event(event):
	tutorial.next_state_on_enter(event)
