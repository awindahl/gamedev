extends TileMap

var mapNodePath = '/root/Game/Navigation2D/Map'
var centrePoint = Vector2(0, 0) setget setCentrePoint, getCentrePoint
var zoomFactor = 1 setget setZoomFactor, getZoomFactor

func load_from_tile_map(tileMap):
	self.set_pos(tileMap.get_pos())
	var mapCells = tileMap.get_used_cells()
	
	for cell in mapCells:
		var tile = tileMap.get_cellv(cell)
		self.set_cellv(cell,tile)

func setCentrePoint(newCentrePoint):
	self.set_pos(-newCentrePoint + Vector2(480.194427, 288.355164))
	centrePoint = newCentrePoint

func getCentrePoint():
	return centrePoint

func setZoomFactor(newZoomFactor):
	self.set_scale(Vector2(1, 1)*newZoomFactor)
	zoomFactor = newZoomFactor
	
func getZoomFactor():
	return zoomFactor

func _input(event):
	if self.is_visible():
		if Input.is_action_pressed("ui_up") :
			self.setCentrePoint(centrePoint + Vector2(0, -30))
		if Input.is_action_pressed("ui_down"):
			self.setCentrePoint(centrePoint + Vector2(0, 30))
		if Input.is_action_pressed("ui_left"):
			self.setCentrePoint(centrePoint + Vector2(-30, 0))
		if Input.is_action_pressed("ui_right"):
			self.setCentrePoint(centrePoint + Vector2(30, 0))
		if (event.type == InputEvent.MOUSE_BUTTON):
			if (event.button_index == BUTTON_WHEEL_UP):
				self.setZoomFactor(1.1*zoomFactor)
			if (event.button_index == BUTTON_WHEEL_DOWN):
				self.setZoomFactor(0.9*zoomFactor)
			

func _ready():
	if has_node(mapNodePath):
		var mapNode = get_node(mapNodePath)
		self.load_from_tile_map(mapNode)
	#set_meta("Type", "Map")
	
	set_process_input(true)