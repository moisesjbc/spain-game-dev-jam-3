extends Node2D

var _connections = []
var _generators = []
var _consumers = []

func add_connection(building_0, building_1):
	_connections.append([building_0, building_1])
	
	if 'generators' in building_0.get_groups() and _generators.find(building_0) < 0:
		_generators.append(building_0)
	elif 'generators' in building_1.get_groups() and _generators.find(building_1) < 0:
		_generators.append(building_1)
		
	if 'consumers' in building_0.get_groups():
		_consumers.append(building_0)
	elif 'consumers' in building_1.get_groups():
		_consumers.append(building_1)
		
	_compute_energy()


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
	if 'generators' in connection[0].get_groups():
		connection[0].consumed_energy = 0
		_generators.remove(_generators.find(connection[0]))
	elif 'generators' in connection[1].get_groups():
		connection[1].consumed_energy = 0
		_generators.remove(_generators.find(connection[1]))
		
	if 'consumers' in connection[0].get_groups():
		connection[0].set_energy(0)
		_consumers.remove(_consumers.find(connection[0]))
	elif 'consumers' in connection[1].get_groups():
		connection[1].set_energy(0)
		_consumers.remove(_consumers.find(connection[1]))

	_connections.remove(_connections.find(connection))
	
	_compute_energy()
	

func _compute_energy():
	for generator in _generators:
		generator.consumed_energy = 0
		
	for consumer in _consumers:
		consumer.energy = 0
		
	var energies = {}
	
	for generator in _generators:
		var connected_consumers = _get_connected_consumers(generator, [])
		
		if len(connected_consumers):
			var available_energy = float(generator.total_energy)
			var consumers_requiring_energy = [] + connected_consumers
			
			while available_energy > 0.5 and len(consumers_requiring_energy):
				var current_consumers = [] + consumers_requiring_energy
				consumers_requiring_energy = []
				
				var energy_per_consumer = available_energy / len(current_consumers)
				
				while available_energy and len(current_consumers):
					var current_consumer = current_consumers.pop_back()
					
					if not energies.has(current_consumer.name):
						energies[current_consumer.name] = current_consumer.energy
					
					if energies[current_consumer.name] < current_consumer.max_energy:
						if current_consumer.max_energy - energies[current_consumer.name] >= energy_per_consumer:
							energies[current_consumer.name] += energy_per_consumer
							available_energy -= energy_per_consumer
							
							if current_consumer.max_energy - energies[current_consumer.name] > energy_per_consumer:
								consumers_requiring_energy.push_back(current_consumer)
						else:
							available_energy -= energy_per_consumer - (current_consumer.max_energy - energies[current_consumer.name])
							energies[current_consumer.name] += current_consumer.max_energy - energies[current_consumer.name]
		
			print("energies ", energies)
			for consumer in _consumers:
				if energies.has(consumer.name):
					consumer.set_energy(energies[consumer.name])

	
func _get_connected_consumers(node, visited_consumers):
	var consumers = []
	
	for connection in _connections:
		if (connection[0] == node) and not (connection[1] in visited_consumers) and 'consumers' in connection[1].get_groups():
			consumers = consumers + [connection[1]] + _get_connected_consumers(connection[1], visited_consumers + [connection[1]])
		elif (connection[1] == node) and not (connection[0] in visited_consumers) and 'consumers' in connection[0].get_groups():
			consumers = consumers + [connection[0]] + _get_connected_consumers(connection[0], visited_consumers + [connection[0]])
		
	return consumers
