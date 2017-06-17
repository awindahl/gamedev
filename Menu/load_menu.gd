extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	#see if any files are loaded, assign to right spot else leave as empty
	pass


func _on_BackBtn_pressed():
	get_tree().change_scene("res://Menu/main_menu.tscn")


func _on_File1Btn_pressed():
	main.myFile = 1
	get_tree().change_scene("res://rpg_test/main.tscn")


func _on_File2Btn_pressed():
	main.myFile = 2
	get_tree().change_scene("res://rpg_test/main.tscn")


func _on_File3Btn_pressed():
	main.myFile = 3
	get_tree().change_scene("res://rpg_test/main.tscn")
