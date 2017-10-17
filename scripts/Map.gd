extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func show():
	var player = get_node('/root/Game/Player')
	var map = get_node('Minimap')
	map.setCentrePoint(player.get_pos())
	self.set_hidden(false)
	
func hide():
	self.set_hidden(true)
	
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
