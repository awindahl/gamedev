extends Control

func _ready():
	
	
	set_fixed_process(true)
	
func _fixed_process(delta):
	
	#--- Quit ---
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
		
func _on_Quit_pressed():
	#--- Quit ---
	get_tree().quit()

func _on_NewGame_pressed():
	get_tree().change_scene("res://top-down movement GRID/Game.tscn")
