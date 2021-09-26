extends Node2D

var _connections = []
var _generators = []
var _consumers = []
var player = null
signal connection_added
signal connection_removed


func add_connection(building_0, building_1):
	for _connection in _connections:
		if (_connection[0] == building_0 and _connection[1] == building_1) or \
			(_connection[0] == building_1 and _connection[1] == building_0):
			# Connection is already made. Don't duplicate it.
			return
	
	var new_connection = [building_0, building_1, generate_intermediate_points(building_0, building_1)]
	_connections.append(new_connection)
	
	if 'generators' in building_0.get_groups() and _generators.find(building_0) < 0:
		_generators.append(building_0)
	elif 'generators' in building_1.get_groups() and _generators.find(building_1) < 0:
		_generators.append(building_1)
		
	if 'consumers' in building_0.get_groups() and _consumers.find(building_0) < 0:
		_consumers.append(building_0)
	elif 'consumers' in building_1.get_groups() and _consumers.find(building_1) < 0:
		_consumers.append(building_1)
		
	_compute_energy()
	emit_signal('connection_added', new_connection)
	$connection_added.play()
	

func get_closest_point_and_distance(ref_position):
	if len(_connections) == 0:
		return null
		
	var min_distance = _connections[0][2][0].distance_to(ref_position)
	var closest_point = _connections[0][2][0]
	var closest_connection = _connections[0]
	
	for _connection in _connections:
		for connection_point in _connection[2]:
			var distance = connection_point.distance_to(ref_position)
			if distance < min_distance:
				min_distance = distance
				closest_point = connection_point
				closest_connection = _connection

	return [closest_point, min_distance, closest_connection]


func generate_intermediate_points(building_0, building_1):
	var n_points = 5
	var segment_size = (building_1.global_position - building_0.global_position) / n_points
	var points = []

	for i in range(1, n_points):
		points.push_back(building_0.global_position + i * segment_size)
		
	return points


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
	_connections.remove(_connections.find(connection))
	
	_remove_node_if_not_connected_to_anything(connection[0])
	_remove_node_if_not_connected_to_anything(connection[1])

	_compute_energy()

	emit_signal('connection_removed')
	$connection_removed.play()


func _remove_node_if_not_connected_to_anything(node):
	if not len(_get_connected_consumers(node, [])):
		if 'generators' in node.get_groups():
			node.consumed_energy = 0
			var generator_index = _generators.find(node)
			if generator_index >= 0:
				_generators.remove(generator_index)
		elif 'consumers' in node.get_groups():
			node.set_energy(0)
			var consumer_index = _consumers.find(node)
			if consumer_index >= 0:
				_consumers.remove(consumer_index)


func _compute_energy():
	for generator in _generators:
		generator.consumed_energy = 0
		
	for consumer in _consumers:
		consumer.energy = 0
		
	var energies = {}
	
	for generator in _generators:
		var connected_consumers = _get_connected_consumers(generator, [])
		
		if len(connected_consumers):
			var available_energy = generator.total_energy
			var consumers_requiring_energy = [] + connected_consumers
			
			while available_energy > 0.5 and len(consumers_requiring_energy):
				var current_consumers = [] + consumers_requiring_energy
				consumers_requiring_energy = []
				
				while available_energy and len(current_consumers):
					var current_consumer = current_consumers.pop_back()
					
					if not energies.has(current_consumer.name):
						energies[current_consumer.name] = current_consumer.energy
					
					var energy_to_add = _calculate_energy_for_consumer(available_energy, len(current_consumers) + 1)
					if energies[current_consumer.name] < current_consumer.max_energy:
						if current_consumer.max_energy - energies[current_consumer.name] >= energy_to_add:
							energies[current_consumer.name] += energy_to_add
							available_energy -= energy_to_add
							
							if current_consumer.max_energy - energies[current_consumer.name] > energy_to_add:
								consumers_requiring_energy.push_back(current_consumer)
						else:
							available_energy -= energy_to_add - (current_consumer.max_energy - energies[current_consumer.name])
							energies[current_consumer.name] += current_consumer.max_energy - energies[current_consumer.name]
		
			print("energies ", energies)
			for consumer in _consumers:
				if energies.has(consumer.name):
					print('consumer ', consumer.name, ' -> ', energies[consumer.name])
					consumer.set_energy(energies[consumer.name])


func _calculate_energy_for_consumer(available_energy, n_consumers):
	if available_energy >= n_consumers:
		return (available_energy / n_consumers)
	else:
		return 1


func _get_connected_consumers(node, visited_consumers):
	return _get_connected_nodes(node, visited_consumers, '_node_is_consumer')


func _node_is_consumer(node):
	return 'consumers' in node.get_groups()


func _get_connected_nodes(node, visited_nodes, condition_predicate):
	var connected_nodes = []
	
	for connection in _connections:
		if (connection[0] == node) and not (connection[1] in visited_nodes):
			if condition_predicate == null or call(condition_predicate, connection[1]):
				connected_nodes = connected_nodes + [connection[1]]
			connected_nodes = connected_nodes + _get_connected_nodes(connection[1], visited_nodes + [connection[1]], condition_predicate)
		elif (connection[1] == node) and not (connection[0] in visited_nodes):
			if condition_predicate == null or call(condition_predicate, connection[0]):
				connected_nodes = connected_nodes + [connection[0]]
			connected_nodes = connected_nodes + _get_connected_nodes(connection[0], visited_nodes + [connection[0]], condition_predicate)
		
	return connected_nodes


func _on_closest_point_calculation_cooldown_timeout():
	var point_and_distance = get_closest_point_and_distance(player.global_position)
	if point_and_distance and point_and_distance[1] < 150:
		$disconnect_button_position.global_position = point_and_distance[0]
		$disconnect_button_position.visible = true
	else:
		$disconnect_button_position.visible = false


func _on_disconnect_button_pressed():
	var point_and_distance = get_closest_point_and_distance(player.global_position)
	if point_and_distance:
		disconnect_connection(point_and_distance[2])
		
		
func clear_connections():
	for generator in _generators:
		generator.consumed_energy = 0
		
	for consumer in _consumers:
		consumer.set_energy(0)

	_connections = []
	_generators = []
	_consumers = []
