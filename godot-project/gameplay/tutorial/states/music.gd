extends Node


var tutorial


func on_init(info_text: RichTextLabel):
	info_text.bbcode_text = '[center]¡Enhorabuena por llegar hasta aquí!. Disfruta de unos segundos de esta canción épica como recompensa. Pulsa [ENTER] para continuar[/center]'


func on_event(event):
	tutorial.next_state_on_enter(event)
