extends Panel


func _ready():
	set_life(3)


func set_life(life):
	for i in range(0, life):
		$margin_container/hbox_container.get_child(i).visible = true
	for i in range(life, 3):
		$margin_container/hbox_container.get_child(i).visible = false


func _on_player_player_hit(player_life):
	set_life(player_life)
