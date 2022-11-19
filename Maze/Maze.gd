extends Spatial


const N = 1 					# binary 0001
const E = 2 					# binary 0010
const S = 4 					# binary 0100
const W = 8 					# binary 1000

var cell_walls = {
	Vector2(0, -1): N, 			# cardinal directions for NESW
	Vector2(1, 0): E,
	Vector2(0, 1): S, 
	Vector2(-1, 0): W
}

onready var minimap = get_node("/root/Game/UI/VP/Map_Container/Minimap")
var map = []

var tiles = [
	preload("res://Maze/Tile00.tscn")	# all the tiles we created
	,preload("res://Maze/Tile01.tscn")
	,preload("res://Maze/Tile02.tscn")
	,preload("res://Maze/Tile03.tscn")
	,preload("res://Maze/Tile04.tscn")
	,preload("res://Maze/Tile05.tscn")
	,preload("res://Maze/Tile06.tscn")
	,preload("res://Maze/Tile07.tscn")
	,preload("res://Maze/Tile08.tscn")
	,preload("res://Maze/Tile09.tscn")
	,preload("res://Maze/Tile10.tscn")
	,preload("res://Maze/Tile11.tscn")
	,preload("res://Maze/Tile12.tscn")
	,preload("res://Maze/Tile13.tscn")
	,preload("res://Maze/Tile14.tscn")
	,preload("res://Maze/Tile15.tscn")
]

var mini_tiles = [
	preload("res://Minimap/Tile00.tscn")
	,preload("res://Minimap/Tile01.tscn")
	,preload("res://Minimap/Tile02.tscn")
	,preload("res://Minimap/Tile03.tscn")
	,preload("res://Minimap/Tile04.tscn")
	,preload("res://Minimap/Tile05.tscn")
	,preload("res://Minimap/Tile06.tscn")
	,preload("res://Minimap/Tile07.tscn")
	,preload("res://Minimap/Tile08.tscn")
	,preload("res://Minimap/Tile09.tscn")
	,preload("res://Minimap/Tile10.tscn")
	,preload("res://Minimap/Tile11.tscn")
	,preload("res://Minimap/Tile12.tscn")
	,preload("res://Minimap/Tile13.tscn")
	,preload("res://Minimap/Tile14.tscn")
	,preload("res://Minimap/Tile15.tscn")
]


var mini_tile = 64

var tile_size = 2 						# 2-meter tiles
var width = 22  						# width of map (in tiles)
var height = 12  						# height of map (in tiles)

onready var Key = preload("res://Key/Key.tscn")
onready var Exit = preload("res://Exit/Exit.tscn")


func _ready():
	randomize()
	make_maze()
	
	var x = (width*tile_size) - 2
	var z = (height*tile_size) -1
	var key = Key.instance()
	key.translate(Vector3(x, 0.2, 1))
	add_child(key)
	var exit = Exit.instance()
	exit.translate(Vector3(x, 0.2, z))
	add_child(exit)


func check_neighbors(cell, unvisited):
	# returns an array of cell's unvisited neighbors
	var list = []
	for n in cell_walls.keys():
		if cell + n in unvisited:
			list.append(cell + n)
	return list
	
func make_maze():
	var unvisited = []  # array of unvisited tiles
	var stack = []
	# fill the map with solid tiles
	for x in range(width):
		map.append([])
		map[x].resize(height)
		for y in range(height):
			unvisited.append(Vector2(x, y))
			map[x][y] = N|E|S|W 		# 15
	var current = Vector2(0, 0)
	unvisited.erase(current)
	while unvisited:
		var neighbors = check_neighbors(current, unvisited)
		if neighbors.size() > 0:
			var next = neighbors[randi() % neighbors.size()]
			stack.append(current)
			var dir = next - current
			var current_walls = map[current.x][current.y] - cell_walls[dir]
			var next_walls = map[next.x][next.y] - cell_walls[-dir]
			map[current.x][current.y] = current_walls
			map[next.x][next.y] = next_walls
			current = next
			unvisited.erase(current)
		elif stack:
			current = stack.pop_back()
	for x in range(width):
		for z in range(height):
			var tile = tiles[map[x][z]].instance()
			tile.translation = Vector3(x*tile_size,0,z*tile_size)
			tile.name = "Tile_" + str(x) + "_" + str(z)
			add_child(tile)
			
			var tile2 = mini_tiles[map[x][z]].instance()
			tile2.position = Vector2(x*mini_tile,z*mini_tile)
			tile2.name = "MTile_" + str(x) + "_" + str(z)
			minimap.add_child(tile2)
