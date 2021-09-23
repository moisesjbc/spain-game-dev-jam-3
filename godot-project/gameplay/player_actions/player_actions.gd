extends Node2D


func init(context: Types.Context):
	var applicable_actions = []
	
	clear()
	
	for player_action in $control/container.get_children():
		var actions = player_action.get_applicable_actions(context)
		if len(actions) > 0:
			applicable_actions += actions

	if len(applicable_actions) > 1:
		visible = true
		for action in applicable_actions:
			action.visible = true
	else:
		if len(applicable_actions) == 1:
			applicable_actions[0].apply()
		visible = false


func clear():
	for action in $control/container.get_children():
		action.visible = false
	
	visible = false
