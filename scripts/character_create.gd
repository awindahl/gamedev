extends Node2D

var s = seed(randi());
var dice = 0;
var name_aquired = false
var dice_rolled = false
var class_chosen = false
var feat_chosen = false
var strengthB = 0
var agilityB = 0
var charismaB = 0 
var intellectB = 0
var classBtn
var feat = ""
var selectedFeat

var totStr
var totAgi
var totCha
var totInt

var classStr
var classAgi
var classCha
var classInt

var modStr = 0;
var modAgi = 0;
var modCha = 0;
var modInt = 0;

var red = Color("ff0000");
var green = Color("00ff00");

func _ready():
	classBtn = get_node("ColorFrame/ClassButton")
	classBtn.add_item(" Select a Base Class ",0);
	classBtn.set_item_disabled(0,true);
	classBtn.add_separator();
	
	classBtn.add_item("Fighter",1);
	classBtn.add_item("Rogue",2);
	classBtn.add_item("Bard",3);
	classBtn.add_item("Mage",4);

	set_fixed_process(true)

func _fixed_process(delta):
	
	#--- name ---
	if !get_node("Name").get_text().empty() && get_node("Name").get_text().is_valid_identifier():
		name_aquired = true
	else:
		name_aquired = false
	
	#--- tot stats ---
	if (strengthB > 0):
		totStr = var2str(round((strengthB + modStr)));
		
		if (totStr.length() == 3):
			totStr = totStr.substr(0,1);
		else:
			totStr = totStr.substr(0,2);
		
		get_node("ColorFrame/Total Stat/Total1").set_bbcode(totStr);
	
	if (agilityB > 0):
		totAgi = var2str(round((agilityB + modAgi)));
		
		if (totAgi.length() == 3):
			totAgi = totAgi.substr(0,1);
		else:
			totAgi = totAgi.substr(0,2);
		get_node("ColorFrame/Total Stat/Total2").set_bbcode(totAgi);
		
	if (charismaB > 0):
		totCha = var2str(round((charismaB + modCha)));
		
		if (totCha.length() == 3):
			totCha = totCha.substr(0,1);
		else:
			totCha = totCha.substr(0,2);
		get_node("ColorFrame/Total Stat/Total3").set_bbcode(totCha);
	
	if (intellectB > 0):
		totInt = var2str(round((intellectB + modInt)));
		
		if (totInt.length() == 3):
			totInt = totInt.substr(0,1);
		else:
			totInt = totInt.substr(0,2);
		get_node("ColorFrame/Total Stat/Total4").set_bbcode(totInt);
	
	#--- class ---
	classStr = get_node("ColorFrame/ClassButton/Modifier1")
	classAgi = get_node("ColorFrame/ClassButton/Modifier2")
	classCha = get_node("ColorFrame/ClassButton/Modifier3")
	classInt = get_node("ColorFrame/ClassButton/Modifier4")
	
	if (classStr.get_bbcode() == "0"):
		classStr.set_visible_characters(0);
	else:
		classStr.set_visible_characters(255);
		if(classStr.get_bbcode().to_int() < 0):
			classStr.add_color_override("default_color", red);
		else:
			classStr.add_color_override("default_color", green);
	classStr.set_bbcode(str(modStr));
	
	if (classAgi.get_bbcode() == "0"):
		classAgi.set_visible_characters(0);
	else:
		classAgi.set_visible_characters(255);
		if(classAgi.get_bbcode().to_int() < 0):
			classAgi.add_color_override("default_color", red);
		else:
			classAgi.add_color_override("default_color", green);
	classAgi.set_bbcode(str(modAgi));
	
	if (classCha.get_bbcode() == "0"):
		classCha.set_visible_characters(0);
	else:
		classCha.set_visible_characters(255);
		if(classCha.get_bbcode().to_int() < 0):
			classCha.add_color_override("default_color", red);
		else:
			classCha.add_color_override("default_color", green);
	classCha.set_bbcode(str(modCha));
	
	if (classInt.get_bbcode() == "0"):
		classInt.set_visible_characters(0);
	else:
		classInt.set_visible_characters(255);
		if(classInt.get_bbcode().to_int() < 0):
			classInt.add_color_override("default_color", red);
		else:
			classInt.add_color_override("default_color", green);
	classInt.set_bbcode(str(modInt));
	
	if(classBtn.get_selected_ID()==1):
		modStr = 2;
		modAgi = 1;
		modCha = 0;
		modInt = -1;
		class_chosen = true;
	
	if(classBtn.get_selected_ID()==2):
		modStr = 0;
		modAgi = 2;
		modCha = 1;
		modInt = 0;
		class_chosen = true;
	
	if(classBtn.get_selected_ID()==3):
		modStr = -1;
		modAgi = 0;
		modCha = 3;
		modInt = 1;
		class_chosen = true;
	
	if(classBtn.get_selected_ID()==4):
		modStr = 0;
		modAgi = 0;
		modCha = 0;
		modInt = 3;
		class_chosen = true;

	#--- Feats ---
	for k in range(get_node("FeatBg").get_children().size()-1):
		if !feat_chosen:
			if get_node("FeatBg").get_child(k).is_pressed():
				feat = str(get_node("FeatBg").get_child(k).get_name())
				feat_chosen = true
				print(feat)
				selectedFeat = get_node("FeatBg").get_child(k)
				
				for l in range(get_node("FeatBg").get_children().size()-1):
					if !(get_node("FeatBg").get_child(l) == selectedFeat):
						get_node("FeatBg").get_child(l).set_disabled(true)
		
		else:
			if !selectedFeat.is_pressed():
				feat = ""
				feat_chosen = false
				print(feat)
				selectedFeat = ""
				for m in range(get_node("FeatBg").get_children().size()-1):
					get_node("FeatBg").get_child(m).set_disabled(false)

	#--- create? ---
	if (feat_chosen && class_chosen && dice_rolled && name_aquired):
		get_node("Next").set_disabled(false);
	else:
		get_node("Next").set_disabled(true);

#--- Roll btn ---
func _on_StatRoller_pressed():
	randomize(s);
	dice_rolled = true;
	# Roll four d20s 
	for i in range(4):
		var dice = int(rand_range(2.0,21.0))/2
		if ( i == 0 ):
			strengthB = dice;
		if ( i == 1 ):
			agilityB = dice;
		if ( i == 2 ):
			charismaB = dice;
		if ( i == 3 ):
			intellectB = dice;
		get_node("ColorFrame/StatDad/StatRoller/Base" + var2str(i)).set_bbcode(str(dice));

#--- back btn ---
func _on_Back_pressed():
	get_tree().change_scene("res://Menu/load_menu.tscn")

#--- next btn ---
func _on_Next_pressed():

#--- new vars ---
	main.myLevel = 1;
	main.myMC = 0;
	main.myExp = 0;
	main.myName = get_node("Name").get_text();
	main.myStr = (strengthB + modStr); #tot str
	main.myAgi = (agilityB + modAgi);  #tot agi
	main.myCha = (charismaB + modCha); #tot cha
	main.myInt = (intellectB + modInt);#tot int
	main.myHp = 10 + main.myStr/2;
	main.myMp = 10 + main.myAgi/2;
	main.myFeat[0] = feat; #skill1
	main.myClass = classBtn.get_item_text(classBtn.get_selected_ID())

	
	main._save_game_state(main.myName);
	
#--- goto next scene --- 
	get_node("Next").set_disabled(true);
	get_tree().change_scene("res://Menu/load_menu.tscn")