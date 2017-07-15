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
<<<<<<< HEAD
	get_tree().change_scene("res://Menu/load_menu.tscn")


func _on_Options_pressed():
	get_tree().change_scene("res://Menu/option_menu.tscn")
=======
	get_tree().change_scene("res://grid-movement/Game.tscn")
>>>>>>> gameplay_feature
