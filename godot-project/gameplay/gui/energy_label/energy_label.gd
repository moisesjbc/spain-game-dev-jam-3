extends Node2D


func _ready():
	set_energy(0)


func set_energy(energy):
	$label.text = str(int(energy)) + '%'
