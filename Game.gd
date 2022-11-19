extends Spatial


func _ready():
	$Objective.visible = true


func _on_Timer_timeout():
	$Objective.visible = false
