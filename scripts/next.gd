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
	
	print (main.pSkills);