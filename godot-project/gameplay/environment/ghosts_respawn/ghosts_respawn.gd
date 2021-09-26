extends Node2D

var ghost_scene = preload("res://gameplay/ghost/ghost.tscn")
var extra_speed = 0


func _ready():
	var main = get_tree().get_root().get_node_or_null('main')
	# If main is not the root node it means that we are in the turorial.
	if main:
		$cooldown_timer.start()

	
func respawn_ghost():
	var ghost = ghost_scene.instance()
	
	var random_offset = randf()
	$path/path_follow.set_unit_offset(random_offset)
	
	get_tree().get_root().get_node('main').add_child(ghost)
	ghost.global_position = $path/path_follow.global_position
	ghost.movement_speed += extra_speed


func _on_cooldown_timer_timeout():
	respawn_ghost()


func _on_difficulty_increment_timer_timeout():
	extra_speed += 5
