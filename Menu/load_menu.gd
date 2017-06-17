extends Control

var file1 = main.mySave1
var file2 = main.mySave2
var file3 = main.mySave3

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	#see if any files are loaded, assign to right spot else leave as empty
	if file1:
		main._load_game_state(file1)
		get_node("File1Btn/File1Label").set_text(main.myName)
		
	if file2:
		main._load_game_state(file2)
		get_node("File2Btn/File2Label").set_text(main.myName)
	if file3:
		main._load_game_state(file3)
		get_node("File3Btn/File3Label").set_text(main.myName)
		
func _on_BackBtn_pressed():
	get_tree().change_scene("res://Menu/main_menu.tscn")


func _on_File1Btn_pressed():
	if (get_node("File1Btn/File1Label").get_text() == "Empty"):
		main.myFile = 1
		get_tree().change_scene("res://rpg_test/main.tscn")
	else:
		get_tree().change_scene("res://top-down movement GRID/Game.tscn")


func _on_File2Btn_pressed():
	if (get_node("File2Btn/File2Label").get_text() == "Empty"):
		main.myFile = 2
		get_tree().change_scene("res://rpg_test/main.tscn")
	else:
		get_tree().change_scene("res://top-down movement GRID/Game.tscn")

func _on_File3Btn_pressed():
	if (get_node("File3Btn/File3Label").get_text() == "Empty"):
		main.myFile = 3
		get_tree().change_scene("res://rpg_test/main.tscn")
	else:
		get_tree().change_scene("res://top-down movement GRID/Game.tscn")