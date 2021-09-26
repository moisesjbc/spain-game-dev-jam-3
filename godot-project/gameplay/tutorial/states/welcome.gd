extends Node


var tutorial


func on_init(info_text: RichTextLabel):
	info_text.bbcode_text = '[center]¡Bienvenido a "Tirando cable"![/center]\n[center]Pulsa cualquier tecla para continuar[/center]'


func on_event(event):
	if event is InputEventKey and event.scancode != KEY_ESCAPE:
		tutorial.next_state()
