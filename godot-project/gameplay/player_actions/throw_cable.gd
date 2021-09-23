extends Button


var context: Types.Context = null


func get_applicable_actions(new_context: Types.Context):
	self.context = new_context
	var cable_roll = context.player.get_node_or_null('cable_roll')
	if cable_roll and context.closest_interactuable and not cable_roll.throwing_cable:
		return [self]
	else:
		return []


func apply():
	var cable_roll = context.player.get_node_or_null('cable_roll')
	cable_roll.start_throwing(context.closest_interactuable)
	context.player_actions.clear()


func _on_throw_cable_pressed():
	apply()
