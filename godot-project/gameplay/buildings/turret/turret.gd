extends Node2D

var targets_in_area = []
var bullet_scene = preload("res://gameplay/items/bullet/bullet.tscn")
var timeout_added_per_missing_energy_unit = 0.1
var min_shoot_charging_timeout = 0.5
var energy = 0
var max_energy = 5

func _ready():
	set_energy(0)


func _on_influence_area_body_entered(body):
	if 'ghosts' in body.get_groups():
		targets_in_area.append(body)
		if energy > 0.2 and len(targets_in_area) == 1:
			_prepare_shoot()


func _on_influence_area_body_exited(body):
	if 'ghosts' in body.get_groups() and body in targets_in_area:
		var target_index = targets_in_area.find(body)
		targets_in_area.remove(target_index)
		if target_index == 0:
			$shoot_charging_timer.stop()
			if energy > 0.2 and len(targets_in_area) > 0:
				_prepare_shoot()


func _physics_process(_delta):
	if energy > 0.2 and len(targets_in_area) > 0:
		$head.look_at(targets_in_area[0].global_position)


func _get_timeout_time():
	return min_shoot_charging_timeout + (max_energy - energy) * timeout_added_per_missing_energy_unit


func _prepare_shoot():
	var shoot_charging_timeout = _get_timeout_time()
	
	$head.look_at(targets_in_area[0].global_position)
	$shoot_charging_timer.start(shoot_charging_timeout)


func shoot():
	if len(targets_in_area) > 0:
		$turret_shot.play()
		var bullet = bullet_scene.instance()
		get_parent().add_child(bullet)
		bullet.global_position = global_position
		bullet.look_at(targets_in_area[0].global_position)
		
		targets_in_area.remove(0)
		if energy > 0.2 and len(targets_in_area) > 0:
			_prepare_shoot()


func _on_shoot_charging_timer_timeout():
	shoot()


func set_energy(new_energy):
	energy = new_energy
	if energy < 0.2:
		$shoot_charging_timer.stop()
	if energy > 0.2 and $shoot_charging_timer.is_stopped() and len(targets_in_area) > 0:
		_prepare_shoot()
	$energy_label.set_energy(energy, max_energy)
