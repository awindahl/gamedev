extends Control

var green = Color(0,255,0)
var yellow = Color(255,255,0)
var red = Color(204,0,0)

var focusing = false

func _ready():
	get_node("Button").grab_focus()
	var campain_texture = get_node("TextureFrame")
	var campain_list = get_node("CampainList")
	
	campain_list.add_item("Introduction: The Attack")
	campain_list.add_item("Following the trail")
	campain_list.add_item("The Ambush at the crossroads")
	campain_list.add_item("The orb of darkness")
	campain_list.add_item("The mysterious howling woods")
	campain_list.add_item("Disturbing the next-door necromancer")
	
	for i in range(campain_list.get_item_count()):
		if i < 2:
			campain_list.set_item_custom_bg_color(i,green)
		elif i < 4:
			campain_list.set_item_custom_bg_color(i,yellow)
		else:
			campain_list.set_item_custom_bg_color(i,red)
			
	get_node("NameLabel").set_text(main.myName)
	get_node("LevelLabel").set_text("Level " + var2str(int(main.myLevel)) + " " + main.myClass)
	get_node("HPLabel").set_text("HP: " + var2str(int(main.myHp)))
	get_node("MPLabel").set_text("MP: " + var2str(int(main.myMp)))
	get_node("MCLabel").set_text("Missions completed: " + var2str(int(main.myMC)))
	if main.myClass == "Mage":
		var image = load("res://Assets/Sprites/boobwiz.png")
		get_node("TextureFrame").set_texture(image)
	
	set_fixed_process(true)
	set_process_input(true)
	
func _input(event):
	if(event.type == InputEvent.KEY) and not focusing:
		get_node("Button").grab_focus()
		focusing = true

func _fixed_process(delta):
	pass


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu/load_menu.tscn")


func _on_GoBtn_pressed():
	#-- TODO: LOAD THE RIGHT MAP --
	get_tree().change_scene("res://Scenes/Game/Game.tscn")