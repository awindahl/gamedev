extends Control

var focusing = false

func _ready():
	get_node("Start").grab_focus()
	set_process_input(true)
	set_fixed_process(true)
	
func _fixed_process(delta):
	
	#--- Quit ---
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
		
func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Menu/main_menu.tscn")
	
func _on_Quit_pressed():
	get_tree().quit()
	
func _input(event):
	if(event.type == InputEvent.KEY) and not focusing:
		get_node("Start").grab_focus()
		focusing = true
