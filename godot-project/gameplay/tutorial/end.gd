extends Node


var tutorial


func on_init(info_text: RichTextLabel):
	info_text.bbcode_text = '[center]Pues tampoco creo que quede bien en la categoría de Sonido...\nPulsa [ENTER] para terminar el tutorial[/center]'


func on_event(event):
	tutorial.next_state_on_enter(event)
