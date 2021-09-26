extends StaticBody2D


signal investigation_completed
signal investigation_points_updated

var target_investigation_points = 100.0
var current_investigation_points = 0.0

var min_investigation_points_per_second = 0.5
var investigation_points_improvement_per_energy_unit = 0.2

var energy = 0
var max_energy = 5


func _ready():
	set_energy(0)


func _on_investigation_timer_timeout():
	var investigation_points = min_investigation_points_per_second + energy * investigation_points_improvement_per_energy_unit
	current_investigation_points += investigation_points
	
	if current_investigation_points >= target_investigation_points:
		current_investigation_points = target_investigation_points
		emit_signal('investigation_completed')

	emit_signal('investigation_points_updated', current_investigation_points)


func set_energy(new_energy):
	energy = new_energy
	
	if energy == 0 and not $investigation_timer.is_stopped():
		$investigation_timer.stop()
	elif energy > 0 and $investigation_timer.is_stopped():
		$investigation_timer.start()
	
	$energy_label.set_energy(energy, max_energy)
