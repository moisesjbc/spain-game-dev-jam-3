extends Node

var tutorial


func on_init(info_text: RichTextLabel):
	info_text.bbcode_text = '[center]¿Qué investigación, te preguntas?\nPulsa [ENTER] para continuar[/center]'


func on_event(event):
	tutorial.next_state_on_enter(event)
