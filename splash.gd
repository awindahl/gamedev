extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	
	#--- Quit ---
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
		
func _on_Start_pressed():
	get_tree().change_scene("res://Menu/main_menu.tscn")
	
func _on_Quit_pressed():
	get_tree().quit()