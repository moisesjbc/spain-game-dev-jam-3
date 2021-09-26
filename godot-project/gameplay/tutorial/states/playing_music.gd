extends Node


var tutorial
var dots = ''
var info_text

func on_init(new_info_text: RichTextLabel):
	info_text = new_info_text
	$timer.start(1)
	info_text.set_text('')


func _on_timer_timeout():
	if dots != "...":
		dots += "."
		info_text.set_text(dots)
	else:
		$timer.stop()
		tutorial.next_state()
