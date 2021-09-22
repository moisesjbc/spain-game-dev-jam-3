extends KinematicBody2D

var targets_in_area = []


func _on_influence_area_body_entered(body):
	if 'phantoms' in body.get_groups():
		targets_in_area.append(body)


func _on_influence_area_body_exited(body):
	if 'phantoms' in body.get_groups() and body in targets_in_area:
		targets_in_area.remove(targets_in_area.find(body))


func _physics_process(_delta):
	if len(targets_in_area) > 0:
		look_at(targets_in_area[0].global_position)
