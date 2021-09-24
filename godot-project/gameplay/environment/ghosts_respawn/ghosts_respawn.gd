extends Node2D

var ghost_scene = preload("res://gameplay/ghost/ghost.tscn")

	
func respawn_ghost():
	var ghost = ghost_scene.instance()
	
	var random_offset = randf()
	$path/path_follow.set_unit_offset(random_offset)
	
	get_tree().get_root().get_node('main').add_child(ghost)
	ghost.global_position = $path/path_follow.global_position


func _on_cooldown_timer_timeout():
	respawn_ghost()
