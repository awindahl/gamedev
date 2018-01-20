extends Control

var focusing = false

func _ready():
	get_node("PlayGame").grab_focus()
	set_process_input(true)
	set_fixed_process(true)
	
func _fixed_process(delta):
	
	#--- Quit ---
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
		
func _on_Quit_pressed():
	#--- Quit ---
	get_tree().quit()

func _on_NewGame_pressed():
	get_tree().change_scene("res://Menu/load_menu.tscn")


func _on_Options_pressed():
	get_tree().change_scene("res://Menu/option_menu.tscn")

func _input(event):
	if(event.type == InputEvent.KEY) and not focusing:
		get_node("PlayGame").grab_focus()
		focusing = true
