extends KinematicBody2D


export (int) var movement_speed = 500
export var hp = 3
var player_actions_scene = preload("res://gameplay/player_actions/player_actions.tscn")

var close_interactuables = []


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
	if Input.is_action_just_pressed('ui_action') and not get_parent().get_node_or_null('player_actions'):
		var player_actions = player_actions_scene.instance()
		get_parent().add_child(player_actions)
		player_actions.global_position = global_position
		var context = Types.Context.create(self, player_actions, _get_closest_interactuable(), get_parent().get_node('connections'))
		player_actions.init(context)


func _get_closest_interactuable():
	var n_close_interactuables = len(close_interactuables)
	if n_close_interactuables == 0:
		return null
	elif n_close_interactuables == 1:
		return close_interactuables[0]
	else:
		var closest_interactuable = close_interactuables[0]
		var closest_distance = global_position.distance_to(close_interactuables[0].global_position)
		for current_index in range(1, n_close_interactuables):
			var distance = global_position.distance_to(close_interactuables[current_index].global_position)
			if distance < closest_distance:
				closest_interactuable = close_interactuables[current_index]
				closest_distance = distance
		return closest_interactuable


func damage():
	hp -= 1
	print('damage! new hp', hp)


func _on_influence_area_body_entered(body):
	if 'interactuables' in body.get_groups() and !get_node_or_null(body.name):
		close_interactuables.append(body)


func _on_influence_area_body_exited(body):
	if 'interactuables' in body.get_groups():
		var index = close_interactuables.find(body)
		if index >= 0:
			close_interactuables.remove(index)
