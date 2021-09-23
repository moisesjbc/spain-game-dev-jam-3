extends VBoxContainer


var context: Types.Context = null
var disconnect_action_scene = preload("res://gameplay/player_actions/disconnect_action.tscn")


func get_applicable_actions(new_context: Types.Context):
	context = new_context
	
	var applicable_actions = []
	
	if context.closest_interactuable:
		for connection in context.connections.get_connections_to(context.closest_interactuable):
			var disconnect_action = disconnect_action_scene.instance()
			disconnect_action.init(context, connection)
			add_child(disconnect_action)
			applicable_actions.append(disconnect_action)
			visible = true
	
	return applicable_actions
