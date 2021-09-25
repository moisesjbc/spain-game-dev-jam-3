extends Node


func change_scene(scene_path):
	var result = get_tree().change_scene(scene_path)
	if result != OK:
		print('Error changing to scene ', scene_path, ': ', result)
