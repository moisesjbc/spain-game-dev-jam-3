extends Node


var tutorial


func on_init(info_text: RichTextLabel):
	info_text.bbcode_text = '[center]Pulsa las teclas a, w, d y s para moverte por el mapa. Ve al recuadro amarillo para continuar.[/center]'
	$target_zone.visible = true


func _on_target_zone_body_entered(body):
	if tutorial:
		tutorial.next_state()
