extends Area

var sound = null
var scene = null

func _ready():
	pass


func _on_Enemy_body_entered(body):
	if body.name == "Player":
		scene = get_tree().change_scene("res://UI/Lose.tscn")


func _on_Area_body_entered(body):
	if body.name == "Player":
		if sound == null:
			sound = get_node_or_null("/root/Game/Zombie")
		if sound != null:
			sound.playing = true
