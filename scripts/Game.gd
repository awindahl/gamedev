extends Node

func _ready():
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