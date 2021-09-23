extends Node2D

var phantom_scene = preload("res://gameplay/phantom/phantom.tscn")

	
func respawn_phantom():
	var phantom = phantom_scene.instance()
	
	var random_offset = randf()
	$path/path_follow.set_unit_offset(random_offset)
	
	get_tree().get_root().get_node('main').add_child(phantom)
	phantom.global_position = $path/path_follow.global_position


func _on_cooldown_timer_timeout():
	respawn_phantom()
