extends KinematicBody

var scene = null
var Player = null

func _ready():
	pass

func _physics_process(_delta):
	if Player == null:
		Player = get_node_or_null("/root/Game/Player")
	if Player != null:
		look_at(Player.global_transform.origin, Vector3.UP)



func _on_Area_body_entered(body):
	if body.name == "Player":
		$Zombie.playing = true


func _on_Hitbox_body_entered(body):
	if body.name == "Player":
		var _scene = get_tree().change_scene("res://UI/Lose.tscn")
