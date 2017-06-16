extends Panel

onready var n = get_children();
var i = 0;
var check_pos = {};

func _ready():
	set_process(true);
	
func _process(delta):
	
	for i in range(n.size()):
		n[i].set_disabled(false);
		
		if check_pos.size() > 2:
			var a = check_pos.values();
			n[str2var(a[0])].set_disabled(false);
			main.sSkills[0] = a[0];
			n[str2var(a[1])].set_disabled(false);
			main.sSkills[1] = a[1];
			n[str2var(a[2])].set_disabled(false);
			main.sSkills[2] = a[2];
			
			n[i].set_disabled(true);
			
		if n[i].is_pressed():
			check_pos[var2str(i)] = var2str(i);
		else:
			check_pos.erase(var2str(i));
		