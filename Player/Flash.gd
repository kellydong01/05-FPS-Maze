extends Spatial

func _on_Timer_timeout():
	hide()


func shoot():
	show()
	$Timer.start()
	$SoundTimer.start()
	$Shoot.playing = true

func _on_SoundTimer_timeout():
	$Shoot.playing = false
