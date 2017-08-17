extends Control

var myMP = main.myMp;
var currentMP = myMP;
var changeInMP = 0;
var e = 0;
var usingMP = false
var diff
var color

func _ready():
	
	get_node("HUD/MPLabel").set_text(var2str(currentMP) + "/" + var2str(myMP))
	if main.myClass == "Fighter":
		color = "FFA500"
	elif main.myClass == "Rogue":
		color = "00FF00"
	elif main.myClass == "Bard":
		color = "FFFF00"
	elif main.myClass == "Mage":
		color = "0000FF"
	get_node("HUD/MPActual").set_frame_color(color)
	set_fixed_process(true)
	
func _fixed_process(delta):
	
	if usingMP:
		currentMP = currentMP - changeInMP*e;
		diff = floor(get_node("HUD/MPOutline").get_size().x*(float(changeInMP)/float(myMP)))
		if currentMP <= 0:
			currentMP = 0
			diff = get_node("HUD/MPActual").get_size().x
			get_node("Button").set_disabled(true)
		if currentMP > myMP:
			currentMP = myMP
			diff = get_node("HUD/MPOutline").get_size().x-get_node("HUD/MPActual").get_size().x
			
		get_node("HUD/MPActual").set_size(Vector2(get_node("HUD/MPActual").get_size().x-e*diff,get_node("HUD/MPActual").get_size().y))
		get_node("HUD/MPLabel").set_text(var2str(currentMP) + "/" + var2str(myMP))
		usingMP = false;
		changeInMP = 0;

func _on_Button_pressed():
	if currentMP == 0:
		pass
	changeInMP = 2;
	e = 1;
	usingMP = true;
	
func _on_ButtonAdd_pressed():
	if currentMP == myMP:
		pass
	changeInMP = 2;
	e = -1;
	usingMP = true;
	get_node("Button").set_disabled(false)
	
func _on_Btn_quit_desktop_pressed():
	get_tree().quit()

func _on_Btn_quit_menu_pressed():
	get_tree().change_scene("res://Menu/campain_menu.tscn")
	get_tree().set_pause(false)

func _on_Btn_options_pressed():
	pass # replace with function body
	# -- TODO: MAKE CUSTOM OPTIONS MENU FOR INGAME --

func _on_Btn_resume_pressed():
	get_node("Pause").set_hidden(true)
	get_tree().set_pause(false)
	