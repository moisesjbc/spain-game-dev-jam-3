extends Node2D


var building
var player
var connections


func _ready():
	visible = false
	building = get_parent()
	
	for action in $control/container.get_children():
		action.menu = self
		action.building = get_parent()


func open(new_player, new_connections):
	player = new_player
	connections = new_connections
	visible = false
	for action in $control/container.get_children():
		action.visible = action.is_available(player, connections)
		if action.visible:
			visible = true


func reload():
	open(player, connections)


func close():
	visible = false
