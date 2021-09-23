extends Node2D


func _on_player_player_died():
	$gui/ingame_menu.display(Types.IngameMenu.GAME_OVER)


func _on_investigation_centre_investigation_completed():
	$gui/ingame_menu.display(Types.IngameMenu.VICTORY)
