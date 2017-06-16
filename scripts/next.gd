extends Button

var i = 0;
onready var this = get_node(".");

func _ready():
	
	set_process(true);

func _process(delta):
	if main.sSkills.size()>2 && main.class_has_been_chosen && main.dice_has_been_rolled:
		this.set_disabled(false);

func _on_Button_pressed():
	
	for i in range(3):
		main.pSkills.append(main.skillList[str2var(main.sSkills[i])]);
	
	main.myClass.append(main.strength + main.sClass["st_mod"]);
	main.myClass.append(main.agility + main.sClass["ag_mod"]);
	main.myClass.append(main.charisma + main.sClass["ch_mod"]);
	main.myClass.append(main.intellect + main.sClass["it_mod"]);
	main.myClass.append(main.pSkills[0]);
	main.myClass.append(main.pSkills[1]);
	main.myClass.append(main.pSkills[2]);
	
	
	# goto next scene # 
	# multiple clicks appends mutliple times #