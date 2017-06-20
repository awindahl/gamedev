extends Control

var green = Color(0,255,0)
var yellow = Color(255,255,0)
var red = Color(204,0,0)

func _ready():
	
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
	set_fixed_process(true)

func _fixed_process(delta):
	pass


func _on_Button_pressed():
	get_tree().change_scene("res://Menu/load_menu.tscn")
