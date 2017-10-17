extends Node
var map
var minimap
var mapCells
var miniMapCells
var tile

var xBorder = [0,0]; #xborder[0] = left, xborder[1] = right
var yBorder = [0,0]; #yborder[0] = top, yborder[1] = bot
var center = [0,0]; #center[0] = x, center[1] = y
var coolValues


func _ready():
	set_process_input(true)
	set_pause_mode(PAUSE_MODE_PROCESS)

func _input(event):
	if event.is_action_pressed("ui_character") and get_node("gui/HUD/Character").is_hidden():
		if !get_tree().is_paused():
			_pause()
		_close_all()
		get_node("gui/HUD/Character").set_hidden(false)
	elif event.is_action_pressed("ui_character"):
		_close_all()
		_unpause()
		
	if event.is_action_pressed("ui_inventory") and get_node("gui/HUD/Inventory").is_hidden():
		if !get_tree().is_paused():
			_pause()
		_close_all()
		get_node("gui/HUD/Inventory").set_hidden(false)
	elif event.is_action_pressed("ui_inventory"):
		_close_all()
		_unpause()
		
	if event.is_action_pressed("ui_map"):
		
		var minimap = get_node("gui/HUD/Map")
		
		if minimap.is_hidden():
			minimap.show()
			self._pause()
		else:
			minimap.hide()
			self._unpause()
		self._close_all()
		
	if event.is_action_pressed("pause") and get_node("gui/HUD/Pause").is_hidden():
		if !get_tree().is_paused():
			_pause()
		_close_all()
		get_node("gui/HUD/Pause").set_hidden(false)
	elif event.is_action_pressed("pause"):
		_close_all()
		_unpause()
		
	if event.is_action_pressed("ui_exit"):
		if get_tree().is_paused():
			_close_all()
			_unpause()
		else:
			_pause()
			get_node("gui/HUD/Pause").set_hidden(false)
			
func _unpause():
	get_tree().set_pause(false)

func _pause():
	get_tree().set_pause(true)

func _close_all():
	get_node("gui/HUD/Character").set_hidden(true)
	get_node("gui/HUD/Inventory").set_hidden(true)
#	get_node("gui/HUD/Map").set_hidden(true)
	get_node("gui/HUD/Pause").set_hidden(true)
	