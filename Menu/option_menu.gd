extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("Control/Label1").set_text(OS.get_engine_version().to_json())
	if OS.is_vsync_enabled():
		get_node("Control/Button2/Label").set_text("Vsync on")
	else:
		get_node("Control/Button2/Label").set_text("Vsync off")

func _on_Button_pressed():
	if OS.is_window_fullscreen():
		OS.set_window_fullscreen(false)
	else:
		OS.set_window_fullscreen(true)

func _on_BackBtn_pressed():
	get_tree().change_scene("res://Menu/main_menu.tscn")


func _on_Button2_pressed():
	if OS.is_vsync_enabled():
		OS.set_use_vsync(false)
		print("off")
		get_node("Control/Button2/Label").set_text("Vsync off")
	else:
		OS.set_use_vsync(true)
		print("on")
		get_node("Control/Button2/Label").set_text("Vsync on")
