extends TextureButton


var menu
var building
var player


func is_available(new_player, connections):
	player = new_player
	var cable_roll = player.get_node_or_null('cable_roll')
	return cable_roll and not cable_roll.throwing_cable
	

func _on_throw_cable_button_pressed():
	var cable_roll = player.get_node_or_null('cable_roll')
	if cable_roll:
		cable_roll.start_throwing(building)
		menu.reload()
