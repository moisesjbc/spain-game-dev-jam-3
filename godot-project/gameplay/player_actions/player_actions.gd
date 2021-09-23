extends Node2D


func _ready():
	visible = false


func init(context: Types.Context):
	var applicable_actions = []
	
	for player_action in $container.get_children():
		var actions = player_action.get_applicable_actions(context)
		if len(actions) > 0:
			applicable_actions += actions
		
	if len(applicable_actions) > 1:
		for action in applicable_actions:
			visible = true
	if len(applicable_actions) == 1:
		applicable_actions[0].apply()
		visible = false
	else:
		queue_free()
