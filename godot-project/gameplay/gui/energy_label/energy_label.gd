extends Node2D


func set_energy(energy, max_energy):
	$label.text = str(energy)  + ' / ' + str(max_energy)
