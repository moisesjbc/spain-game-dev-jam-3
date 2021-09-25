extends KinematicBody2D

var target = null
export (int) var movement_speed = 100
signal ghost_hit_by_bullet


func _ready():
	var main = get_tree().get_root().get_node_or_null("main")
	if not main:
		main = get_tree().get_root().get_node("tutorial/main")

	target = main.get_node("player")



func _physics_process(delta):
	look_at(target.global_position)
	_move_to_target(delta)


func _move_to_target(delta):
	var direction = (target.global_position - global_position).normalized()
	
	var _collision = move_and_collide(direction * movement_speed * delta)
	if _collision and _collision.collider.name == 'player':
		_collision.collider.damage()
		queue_free()


func hit_ghost():
	queue_free()
	emit_signal('ghost_hit_by_bullet')
