extends Node2D


func get_building_respawn_position():
	var position_index = randi() % len($buildings_respawn_areas.get_children())
	var respawn_area = $buildings_respawn_areas.get_child(position_index)

	var respawn_position = respawn_area.global_position
	respawn_position.x += -50 + randi() % 100
	respawn_position.y += -50 + randi() % 100

	$buildings_respawn_areas.remove_child(respawn_area)

	return respawn_position
