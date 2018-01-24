extends Control

#General HUD:
onready var myHP = get_parent().get_parent().get_node("Player").hp
onready var currentHP = myHP;
onready var myMP = get_parent().get_parent().get_node("Player").mp
onready var currentMP = myMP;
var changeInMP = 0;
var e = 0;
var usingMP = false
var diff
var color
var focused = false

#Map:
var zoomed = false
var mapcenter = [0,0]

#Inventory:
var arraySlots
var currentSelection
var moving = true
var selecting = false
var checkUp
var checkDown
var checkLeft
var checkRight
var keys
var keyPress
var keyCheck
var slowdown = 15 #ghetto timer needs changing to more sofisticated timer

func _ready():
	#General HUD:
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
	
	#Inventory:
	arraySlots = get_node("Inventory/ItemFrame").get_children()
	currentSelection = arraySlots[0]
	checkUp = get_node("Inventory/Selector/UpCast")
	checkDown = get_node("Inventory/Selector/DownCast")
	checkLeft = get_node("Inventory/Selector/LeftCast")
	checkRight =  get_node("Inventory/Selector/RightCast")
	
	set_fixed_process(true)
	set_process_input(true)
	
func _input(event):
	#Map
	if get_node("Map").is_visible():
		if event.is_action_pressed("ui_select"):
			if zoomed:
				zoomed = false
			else:
				zoomed = true
				
	#Inventory
	if get_node("Inventory").is_visible():
		if event.is_action_pressed("ui_action") and !get_node("Inventory/Selector/Box").is_visible():
			selecting = true
			print("Selected: " + currentSelection.get_name())
			get_node("Inventory/Selector/Box").show()
			get_node("Inventory/Selector/Box/Use").grab_focus()
			

func _fixed_process(delta):
	#General HUD:
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

	if get_node("TextBox").is_visible():
		get_tree().set_pause(true)

	if get_node("Pause").is_visible() and not focused:
		get_node("Pause/Btn_resume").grab_focus()
		focused = true
	
	if not get_node("Pause").is_visible():
		focused = false

	if get_node("Inventory").is_visible():
		checkUp.add_exception(currentSelection)
		checkDown.add_exception(currentSelection)
		checkLeft.add_exception(currentSelection)
		checkRight.add_exception(currentSelection)
		if !moving and !selecting:
			keys = [
				["move_up", checkUp], 
				["move_down", checkDown],
				["move_left", checkLeft],
				["move_right", checkRight]
				]
			for keyPair in keys:
				keyPress = keyPair[0]
				keyCheck = keyPair[1]
				if Input.is_action_pressed(keyPress):
					keyCheck.set_enabled(true)
					if keyCheck.is_colliding():
						print(keyCheck.get_collider())
						get_node("Inventory/Selector").set_pos(get_node("Inventory/ItemFrame").get_pos() + keyCheck.get_collider().get_pos())
						currentSelection = keyCheck.get_collider()
						keyCheck.set_enabled(false)
						checkUp.clear_exceptions()
						checkDown.clear_exceptions()
						checkLeft.clear_exceptions()
						checkRight.clear_exceptions()
						get_node("Inventory/RichTextLabel").add_text("Selected item in inventory slot " + currentSelection.get_name()); get_node("Inventory/RichTextLabel").newline()
						moving = true
		if slowdown > 0:
			slowdown -=1
		
		if slowdown < 1:
			moving = false
			slowdown = 15

	if get_node("Character").is_visible():
		pass

	if get_node("GameOver").is_visible():
		for i in range (0,10) :
			if get_node("GameOver/FadePanel").get_opacity() < 10:
				get_node("GameOver/FadePanel").set_opacity(get_node("GameOver/FadePanel").get_opacity()+(0.0001*i))
			else:
				pass

func _textbox_print( content ):
	var box = get_node("TextBox")
	box.get_node("RichTextLabel").set_bbcode(content)
	box.show()

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

func _on_Btn_resume_pressed():
	get_node("Pause").set_hidden(true)
	get_tree().set_pause(false)

func _on_Btn_options_pressed():
	get_node("Options").show()
	get_node("Options/CloseBtn").grab_focus()
	get_node("Pause/Btn_resume").set_disabled(true)
	get_node("Pause/Btn_options").set_disabled(true)
	get_node("Pause/Btn_quit_menu").set_disabled(true)
	get_node("Pause/Btn_quit_desktop").set_disabled(true)

func _on_CloseBtn_pressed():
	get_node("Options").hide()
	get_node("Pause/Btn_resume").set_disabled(false)
	get_node("Pause/Btn_options").set_disabled(false)
	get_node("Pause/Btn_quit_menu").set_disabled(false)
	get_node("Pause/Btn_quit_desktop").set_disabled(false)
	get_node("Pause/Btn_options").grab_focus()

func _on_FullscreenBtn_pressed():
	OS.set_window_resizable(true)
	if OS.is_window_fullscreen():
		OS.set_window_fullscreen(false)
	else:
		OS.set_window_fullscreen(true)

func _on_VsyncBtn_pressed():
	if OS.is_vsync_enabled():
		OS.set_use_vsync(false)
		print("off")
		get_node("Options/VsyncBtn/VsyncLabel").set_text("Vsync off")
	else:
		OS.set_use_vsync(true)
		print("on")
		get_node("Options/VsyncBtn/VsyncLabel").set_text("Vsync on")

func _on_Btn_Retry_pressed():
	get_parent().get_tree().set_pause(false)
	get_tree().reload_current_scene()
	get_node("GameOver").hide()

func _on_Btn_Quit_pressed():
	get_tree().change_scene("res://Scenes/Menu/campain_menu.tscn")
	get_tree().set_pause(false)

func _on_Btn_Back_pressed():
	get_node("Inventory/Selector/Box").hide()
	selecting = false
	slowdown = 15