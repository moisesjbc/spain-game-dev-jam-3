extends Control


func _ready():
	$center_container/vbox_container/buttons_container/exit_button.visible = (OS.get_name() != "HTML5")


func _on_plain_button_pressed():
	var erro = Utils.change_scene("res://gameplay/main/main.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
