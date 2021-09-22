extends Node2D

var _connections = []


func add_connection(building_0, building_1):
	_connections.append([building_0, building_1])


func _physics_process(delta):
	update()


func _draw():
	for _connection in _connections:
		draw_line(to_local(_connection[0].global_position), to_local(_connection[1].global_position), Color.orange, 3)
