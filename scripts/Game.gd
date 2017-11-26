extends Node

var mapCells
var miniMapCells
var tile

var xBorder = [0,0]; #xborder[0] = left, xborder[1] = right
var yBorder = [0,0]; #yborder[0] = top, yborder[1] = bot
var center = [0,0]; #center[0] = x, center[1] = y
var coolValues
# ----------------- load values from main -----------------
var myName = main.myName
var mySprite = main.mySprite
var myInventory = main.myInventory
var myWep = main.myWep
var myEquip = main.myEquip
var myExp = main.myExp
var myLevel = main.myLevel
var myAbilities = main.myAbilities
var myMC = main.myMC
var myHp = main.myHp
var myMp = main.myMp
var myStr = main.myStr
var myAgi = main.myAgi
var myCha = main.myCha
var myInt = main.myInt
var myFeat = main.myFeat
var myClass = main.myClass

func _ready():
	
	# -- TODO: LOAD MINIMAP + FOW(?)
	mapCells = get_node("Navigation2D/TileMap").get_used_cells()
	miniMapCells = get_node("gui/Node2D/Map/TilePanel/TileMap")
	for cells in mapCells:
		tile = get_node("Navigation2D/TileMap").get_cellv(mapCells[mapCells.find(cells)])
		miniMapCells.set_cell(mapCells[mapCells.find(cells)][0],mapCells[mapCells.find(cells)][1],tile,false,false,false)
		
	#-------------------------------------------
	#print( miniMapCells.get_used_cells().size())
	for i in miniMapCells.get_used_cells():
		if !(miniMapCells.get_cellv(miniMapCells.get_used_cells()[miniMapCells.get_used_cells().find(i)]) == -1):
			coolValues = get_node("gui/Node2D/Map/TilePanel/TileMap").map_to_world(Vector2(miniMapCells.get_used_cells()[miniMapCells.get_used_cells().find(i)][0],miniMapCells.get_used_cells()[miniMapCells.get_used_cells().find(i)][1]),false)
			if coolValues.x < xBorder[0]:
				xBorder[0] = coolValues.x
			if coolValues.x > xBorder[1]:
				xBorder[1] = coolValues.x
			if coolValues.y < yBorder[0]:
				yBorder[0] = coolValues.y 
			if coolValues.y > yBorder[0]:
				yBorder[1] = coolValues.y
	center[0] = ((xBorder[0]+xBorder[1])/2)-get_node("gui/Node2D/Map/TilePanel").get_pos().x
	center[1] = ((yBorder[0]+yBorder[1])/2)-get_node("gui/Node2D/Map/TilePanel").get_pos().y
	get_node("gui/Node2D").mapcenter = center
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
	
func _calculate_damage(id,damage):
	print(id.get_name(),damage)
	get_node(id.get_name()).hp = get_node(id.get_name()).hp - damage
	if id.get_name() == "Player":
		print("hurtin player")
		_player_hurt(damage)

func _player_hurt(damage):
	print(damage)
	get_node("gui/Node2D")._update_hp(damage,1)
	get_node("Player")._on_player_hit()
	
func _player_dead():
	get_node("Player").get_tree().set_pause(true)
	set_process_input(false)