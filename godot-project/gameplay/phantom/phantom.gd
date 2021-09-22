extends KinematicBody2D

onready var target = get_tree().get_root().get_node("main/player")
export (int) var movement_speed = 250


func _physics_process(delta):
	look_at(target.global_position)
	_move_to_target(delta)


func _move_to_target(delta):
	var direction = (target.global_position - global_position).normalized()
	
	var _collision = move_and_collide(direction * movement_speed * delta)
	if _collision and _collision.collider.name == 'player':
		_collision.collider.damage()
		queue_free()
