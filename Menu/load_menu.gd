extends Control

var file1 = main.mySave1
var file2 = main.mySave2
var file3 = main.mySave3
var deleteActive = false

func _ready():
	_load()
	
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
	get_tree().change_scene("res://Menu/main_menu.tscn")

func _on_File1Btn_pressed():
	if deleteActive:
		main._delete_save(file1)
		file1 = null
		main.mySave1 = null
		main._game_data()
		main._update_game_data()
		_load()
		get_node("File1Btn").set_disabled(true)
	else:
		if (get_node("File1Btn/File1Label").get_text() == "Empty"):
			main.myFile = 1
			get_tree().change_scene("res://rpg_test/main.tscn")
		else:
			get_tree().change_scene("res://top-down movement GRID/Game.tscn")

func _on_File2Btn_pressed():
	if deleteActive:
		main._delete_save(file2)
		file2 = null
		main.mySave2 = null
		main._game_data()
		main._update_game_data()
		_load()
		get_node("File2Btn").set_disabled(true)
	else:
		if (get_node("File2Btn/File2Label").get_text() == "Empty"):
			main.myFile = 2
			get_tree().change_scene("res://rpg_test/main.tscn")
		else:
			get_tree().change_scene("res://top-down movement GRID/Game.tscn")

func _on_File3Btn_pressed():
	if deleteActive:
		main._delete_save(file3)
		file3 = null
		main.mySave3 = null
		main._game_data()
		main._update_game_data()
		_load()
		get_node("File3Btn").set_disabled(true)
	else:
		if (get_node("File3Btn/File3Label").get_text() == "Empty"):
			main.myFile = 3
			get_tree().change_scene("res://rpg_test/main.tscn")
		else:
			get_tree().change_scene("res://top-down movement GRID/Game.tscn")

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