extends Node2D

onready var Player = null

func _physics_process(_delta):
	if Player == null:
		Player = get_node_or_null("/root/Game/Player")
	if Player != null:
		var p = Player.global_transform.origin
		rotation_degrees = Player.rotation_degrees.y
