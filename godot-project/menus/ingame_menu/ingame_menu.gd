extends CenterContainer


func display(type):
	get_tree().paused = true
	visible = true
	
	if type == Types.IngameMenu.GAME_OVER:
		$panel/margin_container/vbox_container/title_label.text = 'GAME OVER'
		$panel/margin_container/vbox_container/restart_button.text = 'Empezar de nuevo'
	elif type == Types.IngameMenu.VICTORY:
		$panel/margin_container/vbox_container/title_label.text = '¡Victoria!'
		$panel/margin_container/vbox_container/restart_button.text = 'Empezar de nuevo'


func unpause():
	get_tree().paused = false
	visible = false


func _on_restart_button_pressed():
	unpause()
	Utils.change_scene("res://gameplay/main/main.tscn")


func _on_return_to_main_menu_button_pressed():
	unpause()
	Utils.change_scene("res://menus/main_menu/main_menu.tscn")
