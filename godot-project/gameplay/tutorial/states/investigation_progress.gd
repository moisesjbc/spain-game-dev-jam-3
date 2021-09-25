extends Node


var tutorial


func on_init(info_text: RichTextLabel):
	info_text.bbcode_text = '[center]¡Muy bien! Para ganar tendrás que aguantar hasta que la investigación concluya (barra superior derecha). Cuanta más energía tenga el centro, más rápido irá. Pulsa [ENTER] para continuar[/center]'


func on_event(event):
	tutorial.next_state_on_enter(event)
