# Collection of functions to work with a Grid. Stores all its children in the grid array
extends TileMap

enum ENTITY_TYPES {PLAYER, OBSTACLE, COLLECTIBLE}

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2
var grid_size = Vector2(50, 50)

var grid = []
onready var Player = preload("res://top-down movement GRID/Player.tscn")
onready var Obstacle = preload("res://top-down movement GRID/Obstacle.tscn")
onready var Enemy = preload("res://top-down movement GRID/Enemy.tscn")

func _ready():
	
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)

	# Player
	var new_player = Player.instance()
	new_player.set_pos(map_to_world(Vector2(4,4)) + half_tile_size)
	add_child(new_player)
	
	#creates test obstacle
	var new_obstacle = Obstacle.instance()
	new_obstacle.set_pos(map_to_world(Vector2(5,5))+half_tile_size)
	# occupies a grid tile
	grid[5][5] = new_obstacle.get_name()
	add_child(new_obstacle)
	
	var new_enemy = Enemy.instance()
	new_enemy.set_pos(map_to_world(Vector2(6,6))+half_tile_size)
	add_child(new_enemy)

func get_cell_content(pos=Vector2()):
	return grid[pos.x][pos.y]


func is_cell_vacant(pos=Vector2(), direction=Vector2()):
	var grid_pos = world_to_map(pos) + direction

	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			return true if grid[grid_pos.x][grid_pos.y] == null else false
	return false


func update_child_pos(new_pos, direction, type):
	# Remove node from current cell, add it to the new cell, returns the new target move_to position
	var grid_pos = world_to_map(new_pos)
	print(grid_pos)
	grid[grid_pos.x][grid_pos.y] = null
	
	var new_grid_pos = grid_pos + direction
	grid[new_grid_pos.x][new_grid_pos.y] = type
	
	var target_pos = map_to_world(new_grid_pos) + half_tile_size
	return target_pos
