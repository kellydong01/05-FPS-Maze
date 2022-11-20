extends Spatial

onready var Enemy = preload("res://Enemy/Enemy.tscn")
onready var Maze = get_node_or_null("/root/Game/Maze")
export var count = 15

func _ready():
	var locations = []
	for x in range(1, Maze.width-2):
		for z in range(Maze.height-2):
			var X = ((x+1) * Maze.tile_size) - 2
			var Z = ((z+1) * Maze.tile_size) - 2
			locations.append(Vector3(X, 0.2, Z))
	locations.shuffle()
	for i in range(count):
		var enemy = Enemy.instance()
		enemy.translate(locations[i])
		add_child(enemy)
