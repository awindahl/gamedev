extends Node

var mapCells
var miniMapCells
var tile

func _ready():
	# -- TODO: LOAD MINIMAP + FOW(?)
	mapCells = get_node("Navigation2D/TileMap").get_used_cells()
	miniMapCells = get_node("gui/Node2D/Map/TilePanel/TileMap")
	print (miniMapCells.world_to_map(Vector2(10,10)))
	for cells in mapCells:
		tile = get_node("Navigation2D/TileMap").get_cellv(mapCells[mapCells.find(cells)])
		miniMapCells.set_cell(mapCells[mapCells.find(cells)][0],mapCells[mapCells.find(cells)][1],tile,false,false,false)
	set_process_input(true)
	set_pause_mode(PAUSE_MODE_PROCESS)

func _input(event):
	if event.is_action_pressed("ui_character") and get_node("gui/Node2D/Character").is_hidden():
		if !get_tree().is_paused():
			_pause()
		_close_all()
		get_node("gui/Node2D/Character").set_hidden(false)
	elif event.is_action_pressed("ui_character"):
		_close_all()
		_unpause()
		
	if event.is_action_pressed("ui_inventory") and get_node("gui/Node2D/Inventory").is_hidden():
		if !get_tree().is_paused():
			_pause()
		_close_all()
		get_node("gui/Node2D/Inventory").set_hidden(false)
	elif event.is_action_pressed("ui_inventory"):
		_close_all()
		_unpause()
		
	if event.is_action_pressed("ui_map") and get_node("gui/Node2D/Map").is_hidden():
		if !get_tree().is_paused():
			_pause()
		_close_all()
		get_node("gui/Node2D/Map").set_hidden(false)
	elif event.is_action_pressed("ui_map"):
		_close_all()
		_unpause()
		
	if event.is_action_pressed("pause") and get_node("gui/Node2D/Pause").is_hidden():
		if !get_tree().is_paused():
			_pause()
		_close_all()
		get_node("gui/Node2D/Pause").set_hidden(false)
	elif event.is_action_pressed("pause"):
		_close_all()
		_unpause()
		
	if event.is_action_pressed("ui_exit"):
		if get_tree().is_paused():
			_close_all()
			_unpause()
		else:
			_pause()
			get_node("gui/Node2D/Pause").set_hidden(false)
			
func _unpause():
	get_tree().set_pause(false)

func _pause():
	get_tree().set_pause(true)

func _close_all():
	get_node("gui/Node2D/Character").set_hidden(true)
	get_node("gui/Node2D/Inventory").set_hidden(true)
	get_node("gui/Node2D/Map").set_hidden(true)
	get_node("gui/Node2D/Pause").set_hidden(true)