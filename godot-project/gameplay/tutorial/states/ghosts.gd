extends Node


var tutorial


func on_init(info_text: RichTextLabel):
	info_text.set_text('Pues están investigando cómo vencer la INVASIÓN DE FANTASMAS.\nPulsa [ENTER] para continuar.')


func on_event(event):
	tutorial.next_state_on_enter(event)
