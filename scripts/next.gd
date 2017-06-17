extends Button

var i = 0;
onready var this = get_node(".");

func _ready():
	
	set_process(true);

func _process(delta):
	if (main.all_skills_chosen && main.class_has_been_chosen && main.dice_has_been_rolled && main.name_has_been_entered):
		this.set_disabled(false);
	else:
		this.set_disabled(true);

func _on_Button_pressed():
	
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
	
	main._save_game_state(main.myName);
	
	# goto next scene # 
	# multiple clicks appends mutliple times #