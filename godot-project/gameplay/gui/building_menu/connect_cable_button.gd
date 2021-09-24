extends TextureButton


var menu
var building
var player
var connections


func is_available(new_player, new_connections):
	player = new_player
	connections = new_connections
	var cable_roll = player.get_node_or_null('cable_roll')
	return cable_roll and cable_roll.throwing_cable and cable_roll.origin != building
	

func _on_connect_cable_button_pressed():
	var cable_roll = player.get_node_or_null('cable_roll')
	if cable_roll:
		cable_roll.connect_to(building, connections)
		menu.reload()
