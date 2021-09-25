extends KinematicBody2D

var speed = 1000


func _physics_process(delta):
	var velocity = Vector2(1, 0).rotated(rotation)

	var collision = move_and_collide(velocity * speed * delta)

	if collision and 'ghosts' in collision.collider.get_groups():
		collision.collider.queue_free()
		collision.collider.emit_signal('ghost_hit_by_bullet')
		queue_free()


func _on_visibility_notifier_screen_exited():
	queue_free()
