extends Control

onready var st_output = get_node("RichTextLabel1")
onready var ag_output = get_node("RichTextLabel2");
onready var ch_output = get_node("RichTextLabel3");
onready var it_output = get_node("RichTextLabel4");

func _ready():
	set_process(true);

func _process(delta):
	
	if (main.strength != null):
		var st_tmp = (main.strength + main.sClass["st_mod"]);
		st_tmp = round(st_tmp);
		st_tmp = var2str(st_tmp)
		
		if (st_tmp.length() == 3):
			st_tmp = st_tmp.substr(0,1);
		else:
			st_tmp = st_tmp.substr(0,2);
		
		st_output.set_bbcode(st_tmp);
	
	if (main.agility != null):
		var ag_tmp = (main.agility + main.sClass["ag_mod"]);
		ag_tmp = round(ag_tmp);
		ag_tmp = var2str(ag_tmp)
		
		if (ag_tmp.length() == 3):
			ag_tmp = ag_tmp.substr(0,1);
		else:
			ag_tmp = ag_tmp.substr(0,2);
		ag_output.set_bbcode(ag_tmp);
		
	if (main.charisma != null):
		var ch_tmp = (main.charisma + main.sClass["ch_mod"]);
		ch_tmp = round(ch_tmp);
		ch_tmp = var2str(ch_tmp)
		
		if (ch_tmp.length() == 3):
			ch_tmp = ch_tmp.substr(0,1);
		else:
			ch_tmp = ch_tmp.substr(0,2);
		ch_output.set_bbcode(ch_tmp);
	
	if (main.intellect != null):
		var it_tmp = (main.intellect + main.sClass["it_mod"]);
		it_tmp = round(it_tmp);
		it_tmp = var2str(it_tmp)
		
		if (it_tmp.length() == 3):
			it_tmp = it_tmp.substr(0,1);
		else:
			it_tmp = it_tmp.substr(0,2);
		it_output.set_bbcode(it_tmp);
	