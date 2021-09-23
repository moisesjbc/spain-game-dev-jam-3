extends Button


var context: Types.Context = null


func get_applicable_actions(new_context: Types.Context):
	self.context = new_context
	var cable_roll = context.player.get_node_or_null('cable_roll')
	if cable_roll and not context.closest_interactuable and cable_roll.throwing_cable:
		return [self]
	else:
		return []


func apply():
	var cable_roll = context.player.get_node_or_null('cable_roll')
	
	context.player.remove_child(cable_roll)
	context.player.get_parent().add_child(cable_roll)
	cable_roll.global_position = context.player.global_position
	cable_roll.rotation = context.player.rotation
	cable_roll.get_node('sprite').visible = true
	
	context.player_actions.queue_free()


func _on_leave_cable_pressed():
	apply()
