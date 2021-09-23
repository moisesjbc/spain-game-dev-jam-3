extends Node2D

export (int) var n_generators = 2
export (int) var n_turrets = 4


func _ready():
	_respawn_buildings("res://gameplay/buildings/generator/generator.tscn", n_generators)
	_respawn_buildings("res://gameplay/buildings/turret/turret.tscn", n_turrets)
	_respawn_buildings("res://gameplay/buildings/investigation_centre/investigation_centre.tscn", 1)

func _on_player_player_died():
	$gui/ingame_menu.display(Types.IngameMenu.GAME_OVER)


func _on_investigation_centre_investigation_completed():
	$gui/ingame_menu.display(Types.IngameMenu.VICTORY)


func _respawn_buildings(building_scene_path, n_buildings):
	var building_scene = load(building_scene_path)
	for _i in range(0, n_buildings):
		var building = building_scene.instance()
		building.global_position = $interactuables_respawn.get_building_respawn_position()
		add_child(building)
