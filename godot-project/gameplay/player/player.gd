extends KinematicBody2D


export (int) var movement_speed = 500
export var hp = 3

var close_generator = null


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
	if close_generator and Input.is_action_just_pressed('ui_action'):
		print('Cable!')
		


func damage():
	hp -= 1
	print('damage! new hp', hp)


func _on_influence_area_body_entered(body):
	print(body.get_groups())
	if 'generators' in body.get_groups():
		close_generator = body


func _on_influence_area_body_exited(body):
	if 'generators' in body.get_groups():
		close_generator = null
