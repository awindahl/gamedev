extends Control

var file1 = main.mySave1
var file2 = main.mySave2
var file3 = main.mySave3
var deleteActive = false

var focusing = true

func _ready():
	get_node("File1Btn").grab_focus()
	_load()
	set_process_input(true)

func _input(event):
	if(event.type == InputEvent.KEY) and not focusing:
		get_node("DeleteBtn").grab_focus()
		focusing = true

func _load():
	print("loading")
	if !(file1):
		get_node("File1Btn/File1Label").set_text("Empty")
	elif file1:
		main._load_game_state(file1)
		get_node("File1Btn/File1Label").set_text(main.myName)
		get_node("DeleteBtn").set_disabled(false)
	if !(file2):
		get_node("File2Btn/File2Label").set_text("Empty")
	elif file2:
		main._load_game_state(file2)
		get_node("File2Btn/File2Label").set_text(main.myName)
		get_node("DeleteBtn").set_disabled(false)
	if !(file3):
		get_node("File3Btn/File3Label").set_text("Empty")
	elif file3:
		main._load_game_state(file3)
		get_node("File3Btn/File3Label").set_text(main.myName)
		get_node("DeleteBtn").set_disabled(false)
	
func _on_BackBtn_pressed():
	get_tree().change_scene("res://Scenes/Menu/main_menu.tscn")

func _on_File1Btn_pressed():
	if deleteActive:
		main._delete_save(file1)
		file1 = null
		main.mySave1 = null
		main._game_data()
		main._update_game_data()
		_load()
		get_node("File1Btn").set_disabled(true)
		focusing = false
		get_node("DeleteBtn").grab_focus()
	else:
		if (get_node("File1Btn/File1Label").get_text() == "Empty"):
			main.myFile = 1
			get_tree().change_scene("res://Scenes/Creator/main.tscn")
		else:
			main._load_game_state(file1)
			get_tree().change_scene("res://Scenes/Menu/campain_menu.tscn")

func _on_File2Btn_pressed():
	if deleteActive:
		main._delete_save(file2)
		file2 = null
		main.mySave2 = null
		main._game_data()
		main._update_game_data()
		_load()
		get_node("File2Btn").set_disabled(true)
		focusing = false
		get_node("DeleteBtn").grab_focus()
	else:
		if (get_node("File2Btn/File2Label").get_text() == "Empty"):
			main.myFile = 2
			get_tree().change_scene("res://Scenes/Creator/main.tscn")
		else:
			main._load_game_state(file2)
			get_tree().change_scene("res://Scenes/Menu/campain_menu.tscn")

func _on_File3Btn_pressed():
	if deleteActive:
		main._delete_save(file3)
		file3 = null
		main.mySave3 = null
		main._game_data()
		main._update_game_data()
		_load()
		get_node("File3Btn").set_disabled(true)
		focusing = false
		get_node("DeleteBtn").grab_focus()
	else:
		if (get_node("File3Btn/File3Label").get_text() == "Empty"):
			main.myFile = 3
			get_tree().change_scene("res://Scenes/Creator/main.tscn")
		else:
			main._load_game_state(file3)
			get_tree().change_scene("res://Scenes/Menu/campain_menu.tscn")

func _on_DeleteBtn_pressed():
	if deleteActive:
		get_node("SelectPanel").show()
		deleteActive = false
		get_node("File1Btn").set_disabled(false)
		get_node("File2Btn").set_disabled(false)
		get_node("File3Btn").set_disabled(false)
	else:
		get_node("SelectPanel").hide()
		deleteActive = true
		if (get_node("File1Btn/File1Label").get_text() == "Empty"):
			get_node("File1Btn").set_disabled(true)
		if (get_node("File2Btn/File2Label").get_text() == "Empty"):
			get_node("File2Btn").set_disabled(true)
		if (get_node("File3Btn/File3Label").get_text() == "Empty"):
			get_node("File3Btn").set_disabled(true)