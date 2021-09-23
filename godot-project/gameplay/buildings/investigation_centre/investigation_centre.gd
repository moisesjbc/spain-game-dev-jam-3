extends StaticBody2D


signal investigation_completed


var target_investigation_points = 100.0
var current_investigation_points = 0.0
var investigation_points_per_second = 5.0


func _ready():
	_update_label()


func _on_investigation_timer_timeout():
	current_investigation_points += investigation_points_per_second

	if current_investigation_points >= target_investigation_points:
		current_investigation_points = target_investigation_points
		emit_signal('investigation_completed')

	_update_label()


func _update_label():
	$label.text = str(current_investigation_points) + ' / ' + str(target_investigation_points)
