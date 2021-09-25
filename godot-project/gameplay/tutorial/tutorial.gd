extends Node2D


var current_state_index = 0
var current_state


func _ready():
	set_state(0)


func set_state(new_state_index):
	if current_state and current_state.has_method('on_finish'):
		current_state.on_finish()
	
	current_state_index = new_state_index
	current_state = $states.get_child(current_state_index)
	current_state.tutorial = self
	
	if current_state and current_state.has_method('on_init'):
		current_state.on_init($canvas/info_panel/CenterContainer/info_text)


func _input(event):
	if current_state and current_state.has_method('on_event'):
		current_state.on_event(event)


func next_state():
	if current_state_index + 1 < $states.get_child_count():
		set_state(current_state_index + 1)
	else:
		Utils.change_scene("res://menus/main_menu/main_menu.tscn")
