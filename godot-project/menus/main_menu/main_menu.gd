extends Control


func _ready():
	$center_container/vbox_container/buttons_container/exit_button.visible = (OS.get_name() != "HTML5")


func _on_play_button_pressed():
	Utils.change_scene("res://gameplay/main/main.tscn")


func _on_play_tutorial_button_pressed():
	Utils.change_scene("res://gameplay/tutorial/tutorial.tscn")


func _on_credits_menu_pressed():
	Utils.change_scene("res://menus/credits_menu/credits_menu.tscn")


func _on_exit_button_pressed():
	get_tree().quit()




