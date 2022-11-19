extends Spatial

onready var Enemy = preload("res://Enemy/Enemy.tscn")
onready var Maze = get_node_or_null("/root/Game/Maze")


func _ready():
	var locations = []
	for x in range(Maze.width-2):
		for z in range(Maze.height-2):
			var X = ((x+1) * Maze.tile_size) - 1
			var Z = ((z+1) * Maze.tile_size) - 1
			locations.append(Vector3(X, 0.1, Z))
