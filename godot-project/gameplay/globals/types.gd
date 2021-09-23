extends Node

class Context:
	var player: Node2D
	var player_actions: Node2D
	var closest_interactuable: Node2D
	var connections: Node2D
	
	
	static func create(new_player, new_player_actions, new_closest_interactuable, new_connections):
		var context = Context.new()

		context.player = new_player
		context.player_actions = new_player_actions
		context.closest_interactuable = new_closest_interactuable
		context.connections = new_connections
		
		return context
