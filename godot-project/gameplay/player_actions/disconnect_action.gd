extends Button

var context: Types.Context = null
var connection

func init(new_context, new_connection):
	context = new_context
	connection = new_connection
	var _unused = connect('pressed', self, 'apply')


func apply():
	if context.player.get_node_or_null('cable_roll'):
		var origin = connection[0]
		
		if context.closest_interactuable == connection[0]:
			origin = connection[1]
			
		context.player.get_node('cable_roll').start_throwing(origin)
		context.connections.disconnect_connection(connection)
		
		context.player_actions.clear()
