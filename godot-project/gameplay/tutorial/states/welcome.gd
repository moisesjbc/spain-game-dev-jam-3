extends Node


var tutorial


func on_init(info_text: RichTextLabel):
	info_text.set_text('¡Bienvenido a "Tirando cable"!\nPulsa cualquier tecla para continuar.')


func on_event(event):
	if event is InputEventKey and event.scancode != KEY_ESCAPE:
		tutorial.next_state()
