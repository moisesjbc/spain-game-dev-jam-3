extends KinematicBody2D


export (int) var movement_speed = 500


func _physics_process(delta):
	_process_player_movement(delta)


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
