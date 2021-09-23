extends Node2D


func _on_player_player_died():
	$gui/game_over_menu.display()
