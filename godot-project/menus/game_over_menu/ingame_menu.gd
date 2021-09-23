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


func _on_restart_button_pressed():
	get_tree().paused = false
	visible = false
	var _unused = get_tree().change_scene("res://gameplay/main/main.tscn")
