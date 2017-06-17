extends TextEdit

var myName ="";
onready var this = get_node(".");

func _ready():
	set_process(true);

func _process(delta):
	myName = this.get_text();
	main.myName = myName;
	if this.get_text().length() > 0:
		main.name_has_been_entered = true;
	else:
		main.name_has_been_entered = false;