extends Button

var context: Types.Context = null


func get_applicable_actions(new_context: Types.Context):
	self.context = new_context
	var cable_roll = context.player.get_node_or_null('cable_roll')
	if not cable_roll and context.closest_interactuable and context.closest_interactuable.name == 'cable_roll':
		return [self]
	else:
		return []


func apply():
	var cable_roll = context.closest_interactuable
	
	context.player.get_parent().remove_child(cable_roll)
	context.player.add_child(cable_roll)
	cable_roll.global_position = context.player.global_position
	cable_roll.rotation = context.player.rotation
	cable_roll.get_node('sprite').visible = false
	
	context.player_actions.queue_free()


func _on_leave_cable_pressed():
	apply()
