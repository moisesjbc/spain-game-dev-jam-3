extends Control


func _on_return_to_main_menu_button_pressed():
	Utils.change_scene("res://menus/main_menu/main_menu.tscn")


func _on_credits_text_meta_clicked(meta):
	var result = OS.shell_open(meta)
	if result != OK:
		print('Error opening ', meta, ': ', result)
