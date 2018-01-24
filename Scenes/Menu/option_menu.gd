extends Node

var focusing = false

func _ready():
	get_node("Control/Button").grab_focus()
	get_node("Control/Label1").set_text(OS.get_engine_version().to_json())
	if OS.is_vsync_enabled():
		get_node("Control/Button2/Label").set_text("Vsync on")
	else:
		get_node("Control/Button2/Label").set_text("Vsync off")
	
	set_fixed_process(true)
	set_process_input(true)

func _on_Button_pressed():
	OS.set_window_resizable(true)
	if OS.is_window_fullscreen():
		OS.set_window_fullscreen(false)
	else:
		OS.set_window_fullscreen(true)


func _on_BackBtn_pressed():
	get_tree().change_scene("res://Scenes/Menu/main_menu.tscn")


func _on_Button2_pressed():
	if OS.is_vsync_enabled():
		OS.set_use_vsync(false)
		print("off")
		get_node("Control/Button2/Label").set_text("Vsync off")
	else:
		OS.set_use_vsync(true)
		print("on")
		get_node("Control/Button2/Label").set_text("Vsync on")

func _input(event):
	if(event.type == InputEvent.KEY) and not focusing:
		get_node("Control/Button").grab_focus()
		focusing = true
	
func _fixed_process(delta):
	if get_node("Control/ConfirmationDialog").get_ok().is_pressed():
		if main.mySave1 != null:
			main._delete_save(main.mySave1)
			main.mySave1 = null

		if main.mySave2 != null:
			main._delete_save(main.mySave2)
			main.mySave2 = null
			
		if main.mySave3 != null:
			main._delete_save(main.mySave3)
			main.mySave3 = null
		main._game_data()
		main._update_game_data()
		
	if get_node("Control/ConfirmationDialog").is_visible() == false:
		get_node("Control/BackBtn").set_disabled(false)
		get_node("Control/clearDataBtn").set_disabled(false)
		get_node("Control/Button").set_disabled(false)
		get_node("Control/Button2").set_disabled(false)
		
func _on_clearDataBtn_pressed():
	get_node("Control/ConfirmationDialog").show()
	get_node("Control/BackBtn").set_disabled(true)
	get_node("Control/clearDataBtn").set_disabled(true)
	get_node("Control/Button").set_disabled(true)
	get_node("Control/Button2").set_disabled(true)