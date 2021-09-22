extends KinematicBody2D

var targets_in_area = []
var bullet_scene = preload("res://gameplay/items/bullet/bullet.tscn")
var shoot_charging_timeout = 1


func _on_influence_area_body_entered(body):
	if 'phantoms' in body.get_groups():
		targets_in_area.append(body)
		if len(targets_in_area) == 1:
			_prepare_shoot()
			


func _on_influence_area_body_exited(body):
	if 'phantoms' in body.get_groups() and body in targets_in_area:
		var target_index = targets_in_area.find(body)
		targets_in_area.remove(target_index)
		if target_index == 0:
			$shoot_charging_timer.stop()


func _physics_process(_delta):
	if len(targets_in_area) > 0:
		look_at(targets_in_area[0].global_position)


func _prepare_shoot():
	look_at(targets_in_area[0].global_position)
	$shoot_charging_timer.start(shoot_charging_timeout)


func shoot():
	if len(targets_in_area) > 0:
		var bullet = bullet_scene.instance()
		get_tree().get_root().get_node('main').add_child(bullet)
		bullet.global_position = global_position
		bullet.look_at(targets_in_area[0].global_position)
		
		targets_in_area.remove(0)
		if len(targets_in_area) > 0:
			_prepare_shoot()


func _on_shoot_charging_timer_timeout():
	shoot()
