extends Spatial

func _on_Timer_timeout():
	hide()

func shoot():
	show()
	$Timer.start()
