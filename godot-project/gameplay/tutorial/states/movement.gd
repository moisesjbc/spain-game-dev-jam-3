extends Node


var tutorial


func on_init(info_text: RichTextLabel):
	info_text.set_text('Pulsa las teclas a, w, d y s o las flechas para moverte por el mapa.\nVe al recuadro amarillo para continuar.')
	$target_zone.visible = true


func on_finish():
	$target_zone.visible = false


func _on_target_zone_body_entered(body):
	if tutorial and tutorial.current_state == self and body.name == 'player':
		tutorial.next_state()
