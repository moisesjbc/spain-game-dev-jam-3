extends Node2D

var _connections = []


func add_connection(building_0, building_1):
	_connections.append([building_0, building_1])
	if 'generators' in building_0.get_groups() and 'turrets' in building_1.get_groups():
		building_1.set_energy(1)
	elif 'generators' in building_1.get_groups() and 'turrets' in building_0.get_groups():
		building_0.set_energy(1)


func get_connections_to(building):
	var connections = []

	for _connection in _connections:
		if _connection[0] == building or _connection[1] == building:
			connections.append(_connection)

	return connections


func _physics_process(_delta):
	update()


func _draw():
	for _connection in _connections:
		draw_line(to_local(_connection[0].global_position), to_local(_connection[1].global_position), Color.orange, 3)


func disconnect_connection(connection):
	if 'generators' in connection[0].get_groups() and 'turrets' in connection[1].get_groups():
		connection[1].set_energy(0)
	elif 'generators' in connection[1].get_groups() and 'turrets' in connection[0].get_groups():
		connection[0].set_energy(0)
		
	_connections.remove(_connections.find(connection))
	
	
