extends Node


var tutorial


func on_init(info_text: RichTextLabel):
	info_text.bbcode_text = '[center]¡Bienvenido al turorial![/center]\n[center]Pulsa [ENTER] para continuar[/center]'


func on_event(event):
	if event is InputEventKey and not event.pressed and event.scancode == KEY_ENTER:
		tutorial.next_state()
