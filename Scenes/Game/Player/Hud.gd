extends Control

onready var myHP = get_parent().get_parent().get_node("Player").hp
onready var currentHP = myHP;
onready var myMP = get_parent().get_parent().get_node("Player").mp
onready var currentMP = myMP;
onready var myWeapon = get_parent().get_parent().get_node("Player").weapon
var changeInMP = 0;
var e = 0;
var usingMP = false
var diff
var color
var zoomed = false
var focused = false
var mapcenter = [0,0]

func _ready():
	get_node("HUD/HPLabel").set_text(var2str(currentHP) + "/" + var2str(myHP))
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
	set_process_input(true)
	
func _input(event):
	if get_node("Map").is_visible():
		if event.is_action_pressed("ui_select"):
			if zoomed:
				zoomed = false
			else:
				zoomed = true

func _fixed_process(delta):
	#-- TODO: GET FIRST/LAST TILE BOTH HORIZONTALLY AND VERTICALLY
	#         TO HINDER MAP SCROLLING OUTSIDE OF AREA.
	
	#         ADD OPTION TO REMAP KEYS AND SHOW WHAT KEYS ARE MAPPED
	#         ON THE MAP SCREEN.
	if get_node("Map").is_visible():
		if Input.is_action_pressed("move_up") and (get_node("Map/TilePanel").get_pos().y) < (OS.get_window_size().y+mapcenter[1]-300):
			get_node("Map/TilePanel").set_pos(Vector2(get_node("Map/TilePanel").get_pos().x,get_node("Map/TilePanel").get_pos().y+10))
		if Input.is_action_pressed("move_down") and (get_node("Map/TilePanel").get_pos().y) > 200-mapcenter[1]:
			get_node("Map/TilePanel").set_pos(Vector2(get_node("Map/TilePanel").get_pos().x,get_node("Map/TilePanel").get_pos().y-10))
		if Input.is_action_pressed("move_left") and (get_node("Map/TilePanel").get_pos().x) < OS.get_window_size().x+mapcenter[0]:
			get_node("Map/TilePanel").set_pos(Vector2(get_node("Map/TilePanel").get_pos().x+10,get_node("Map/TilePanel").get_pos().y))
		if Input.is_action_pressed("move_right") and (get_node("Map/TilePanel").get_pos().x) > -mapcenter[0]:
			get_node("Map/TilePanel").set_pos(Vector2(get_node("Map/TilePanel").get_pos().x-10,get_node("Map/TilePanel").get_pos().y))
		if zoomed:
			for i in range (0,3):
				if get_node("Map/TilePanel/TileMap").get_scale() < Vector2(0.5,0.5):
					get_node("Map/TilePanel/TileMap").set_scale(Vector2(get_node("Map/TilePanel/TileMap").get_scale().x+i*0.01,get_node("Map/TilePanel/TileMap").get_scale().y+i*0.01))
		else:
			for i in range (0,3):
				if get_node("Map/TilePanel/TileMap").get_scale() > Vector2(0.2,0.2):
					get_node("Map/TilePanel/TileMap").set_scale(Vector2(get_node("Map/TilePanel/TileMap").get_scale().x-i*0.01,get_node("Map/TilePanel/TileMap").get_scale().y-i*0.01))


	if get_node("Pause").is_visible() and not focused:
		get_node("Pause/Btn_resume").grab_focus()
		focused = true
	if not get_node("Pause").is_visible():
		focused = false
	
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

	if get_node("GameOver").is_visible():
		for i in range (0,10) :
			if get_node("GameOver/FadePanel").get_opacity() < 10:
				get_node("GameOver/FadePanel").set_opacity(get_node("GameOver/FadePanel").get_opacity()+(0.0001*i))
			else:
				pass
		
		
		
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
	get_tree().change_scene("res://Scenes/Menu/campain_menu.tscn")
	get_tree().set_pause(false)

func _on_Btn_options_pressed():
	pass # replace with function body
	# -- TODO: MAKE CUSTOM OPTIONS MENU FOR INGAME --

func _on_Btn_resume_pressed():
	get_node("Pause").set_hidden(true)
	get_tree().set_pause(false)
	
func _update_hp(healthIn,i):
	print(healthIn,i)
	currentHP = currentHP-healthIn*i;
	diff = floor(get_node("HUD/HPOutline").get_size().x*(float(healthIn)/float(myMP)))
	if currentHP <= 0:
		currentHP = 0
		diff = get_node("HUD/HPActual").get_size().x
		get_parent().get_parent()._player_dead()
		get_node("GameOver").show()
		get_node("GameOver/Btn_Retry").grab_focus()
	if currentHP > myHP:
		currentHP = myHP
		diff = get_node("HUD/HPOutline").get_size().x-get_node("HUD/HPActual").get_size().x
	get_node("HUD/HPActual").set_size(Vector2(get_node("HUD/HPActual").get_size().x-diff*i,get_node("HUD/MPActual").get_size().y))
	get_node("HUD/HPLabel").set_text(var2str(currentHP) + "/" + var2str(myHP))
	

func _on_Btn_Retry_pressed():
	get_parent().get_tree().set_pause(false)
	get_tree().reload_current_scene()
	get_node("GameOver").hide()


func _on_Btn_Quit_pressed():
	get_tree().change_scene("res://Scenes/Menu/campain_menu.tscn")
	get_tree().set_pause(false)
