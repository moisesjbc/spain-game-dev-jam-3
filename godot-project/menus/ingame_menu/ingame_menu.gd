extends CenterContainer


var type


func display(new_type):
	type = new_type
	get_tree().paused = true
	visible = true
	
	if type == Types.IngameMenu.GAME_OVER:
		$panel/margin_container/vbox_container/title_label.text = 'GAME OVER'
		$panel/margin_container/vbox_container/restart_button.text = 'Empezar de nuevo'
	elif type == Types.IngameMenu.VICTORY:
		$panel/margin_container/vbox_container/title_label.text = '¡Victoria!'
		$panel/margin_container/vbox_container/restart_button.text = 'Empezar de nuevo'
	else:
		# Pause
		$panel/margin_container/vbox_container/title_label.text = 'Juego pausado'
		
		if get_tree().get_root().get_node_or_null('main'):
			$panel/margin_container/vbox_container/restart_button.text = 'Volver al juego'
		else:
			$panel/margin_container/vbox_container/restart_button.text = 'Volver al tutorial'


func unpause():
	get_tree().paused = false
	visible = false


func _on_restart_button_pressed():
	unpause()
	if type != Types.IngameMenu.PAUSE:
		Utils.change_scene("res://gameplay/main/main.tscn")


func _on_return_to_main_menu_button_pressed():
	unpause()
	Utils.change_scene("res://menus/main_menu/main_menu.tscn")


func _input(event):
	if visible == true and type == Types.IngameMenu.PAUSE and event is InputEventKey and not event.pressed and event.scancode == KEY_ESCAPE:
		unpause()
		
		# Prevent the event from opening the pause menu again.
		get_tree().set_input_as_handled()
