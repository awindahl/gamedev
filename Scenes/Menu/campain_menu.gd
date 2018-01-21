extends Control

var green = Color(0,255,0)
var yellow = Color(255,255,0)
var red = Color(204,0,0)

var socialFeat = "Social people find it easier to interact with others around them making for an easier time around town or out in the world. They are good at [color=green]intimidating[/color], [color=green]persuaing[/color] or [color=green]charming[/color] others; be it friend or foe."
var strongFeat = "Strong people are well built and healthy giving them benefits such as [color=red]more hp[/color], [color=red]greater poise[/color]. They can also [color=red]carry more[/color] than normal people."
var agileFeat = "Agile people can use their skills to traverse what others cannot. They can [color=yellow]use ropes[/color], [color=yellow]climb surfaces[/color] and [color=yellow]cross difficult terrain[/color]."
var educatedFeat = "Educated people are well read and up to speed on wordly matters, their [color=blue]perceptiveness[/color] makes them rarely miss small details around them. [color=blue]Knowledge[/color] makes them cool and they[color=blue]posess knowledge about enemies[/color] giving them an advantage in battle."
var focusFeat = "Focused people stay calm during bad situations and can channel their energies better than others. They use [color=fuchsia]half of the action points[/color] normally needed, have an [color=fuchsia]easier time parrying[/color] and can [color=fuchsia]jump like Link[/color]."
var featFlavour = {
	"": "",
	"Social": socialFeat, 
	"Strong": strongFeat,
	"Agile": agileFeat,
	"Educated": educatedFeat,
	"Focused": focusFeat
	}

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
	get_node("LevelLabel").set_text("A level " + var2str(int(main.myLevel)) + " " + main.myClass + ". (" + var2str(int(main.myExp)) + " experience)")
	get_node("HPLabel").set_text("HP: " + var2str(int(main.myHp)))
	get_node("MPLabel").set_text("MP: " + var2str(int(main.myMp)))
	get_node("MCLabel").set_text("Missions completed: " + var2str(int(main.myMC)))
	get_node("StrLabel").set_text("Strength: " + var2str(int(main.myStr)))
	get_node("AgiLabel").set_text("Agility: " + var2str(int(main.myAgi)))
	get_node("ChaLabel").set_text("Charisma: " + var2str(int(main.myCha)))
	get_node("IntLabel").set_text("Intelligence: " + var2str(int(main.myInt)))
	get_node("FeatLabel").set_text("Feats: " + main.myFeat[0] + "  " + main.myFeat[1] + "  " + main.myFeat[2])
	get_node("FeatExplanation").set_bbcode(featFlavour[main.myFeat[0]] + "\n \n" + featFlavour[main.myFeat[1]] + "\n \n" + featFlavour[main.myFeat[2]])  
	
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
	if get_node("CampainList").is_selected(0):
		get_tree().change_scene("res://Scenes/Campaigns/Campaign 1/Campagin1Level1.tscn")
	elif get_node("CampainList").is_selected(1):
		get_tree().change_scene("res://Scenes/Campaigns/Campaign 1/Campagin1Level2.tscn")
	else:
		pass