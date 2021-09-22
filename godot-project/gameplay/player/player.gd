extends KinematicBody2D


export (int) var movement_speed = 500
export var hp = 3

var close_buildings = []


func _physics_process(delta):
	_process_player_movement(delta)
	_process_player_rotation()
	_process_player_actions()


func _process_player_movement(delta):
	var velocity: Vector2 = Vector2(0.0, 0.0)

	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1

	var _result = move_and_collide(velocity * movement_speed * delta)


func _process_player_rotation():
	look_at(get_global_mouse_position())
	
	
func _process_player_actions():
	if Input.is_action_just_pressed('ui_action'):
		if len(close_buildings):
			if get_node("cable_roll"):
				if not $cable_roll.throwing_cable:
					$cable_roll.start_throwing(_get_closest_building())
				else:
					$cable_roll.connect_to(_get_closest_building(), get_parent().get_node('connections'))
			else:
				var closest_building = _get_closest_building()
				if closest_building.name == 'cable_roll':
					var cable_roll = closest_building
					get_parent().remove_child(cable_roll)
					add_child(cable_roll)
					cable_roll.global_position = global_position
					cable_roll.rotation = rotation
					cable_roll.get_node('sprite').visible = false
		elif !len(close_buildings) and $cable_roll and $cable_roll.throwing_cable:
			var cable_roll = $cable_roll
			remove_child(cable_roll)
			get_parent().add_child(cable_roll)
			cable_roll.global_position = global_position
			cable_roll.rotation = rotation
			cable_roll.get_node('sprite').visible = true
			
			
			
func _get_closest_building():
	var n_close_buildings = len(close_buildings)
	if n_close_buildings == 0:
		return null
	elif n_close_buildings == 1:
		return close_buildings[0]
	else:
		var closest_building = close_buildings[0]
		var closest_distance = global_position.distance_to(close_buildings[0].global_position)
		for current_index in range(1, n_close_buildings):
			var distance = global_position.distance_to(close_buildings[current_index].global_position)
			if distance < closest_distance:
				closest_building = close_buildings[current_index]
				closest_distance = distance
		return closest_building
			
	

func damage():
	hp -= 1
	print('damage! new hp', hp)


func _on_influence_area_body_entered(body):
	if 'buildings' in body.get_groups() and !get_node(body.name):
		close_buildings.append(body)


func _on_influence_area_body_exited(body):
	if 'buildings' in body.get_groups():
		var index = close_buildings.find(body)
		if index >= 0:
			close_buildings.remove(index)
