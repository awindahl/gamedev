extends Node2D


func _ready():

	set_fixed_process(true)

func _fixed_process(delta):
	if (main.all_skills_chosen && main.class_has_been_chosen && main.dice_has_been_rolled && main.name_has_been_entered):
		get_node("Next").set_disabled(false);
	else:
		get_node("Next").set_disabled(false);

func _on_Back_pressed():
	get_tree().change_scene("res://Menu/load_menu.tscn")

func _on_Next_pressed():
		
	for i in range(3):
		main.pSkills[i] = (main.skillList[str2var(main.sSkills[i])]);
	
	main.myClass.resize(7);
	main.myClass[0] = (main.strength + main.sClass["st_mod"]);
	main.myClass[1] = (main.agility + main.sClass["ag_mod"]);
	main.myClass[2] = (main.charisma + main.sClass["ch_mod"]);
	main.myClass[3] = (main.intellect + main.sClass["it_mod"]);
	main.myClass[4] = main.pSkills[0];
	main.myClass[5] = main.pSkills[1];
	main.myClass[6] = main.pSkills[2];
	main.myHp = 10 + main.myClass[0]/2;
	main.myMp = 10 + main.myClass[3]/2;
	main.myLevel = 1;
	main.myMC = 0;
	main.myExp = 0;
	
	main._save_game_state(main.myName);
	
	# goto next scene # 
	get_tree().change_scene("res://Menu/load_menu.tscn")
	# multiple clicks appends mutliple times #