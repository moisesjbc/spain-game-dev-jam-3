extends StaticBody2D


signal investigation_completed
signal investigation_points_updated

var target_investigation_points = 100.0
var current_investigation_points = 0.0

var max_investigation_points_per_second = 2.0
var min_investigation_points_per_second = 0.5

var energy = 0
var max_energy = 3


func _ready():
	set_energy(0)
	_update_label()


func _on_investigation_timer_timeout():
	var investigation_points = min_investigation_points_per_second + (energy / max_energy) * (max_investigation_points_per_second - min_investigation_points_per_second)
	current_investigation_points += investigation_points
	
	if current_investigation_points >= target_investigation_points:
		current_investigation_points = target_investigation_points
		emit_signal('investigation_completed')

	emit_signal('investigation_points_updated', current_investigation_points)

	_update_label()


func _update_label():
	$label.text = str(current_investigation_points) + ' / ' + str(target_investigation_points)


func set_energy(new_energy):
	if energy == 0 and new_energy > 0:
		$investigation_timer.start()
	elif energy > 0 and new_energy == 0:
		$investigation_timer.stop()

	energy = new_energy
	
	$energy_label.set_energy(energy, max_energy)
