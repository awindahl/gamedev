extends OptionButton

var st_mod = 0;
var ag_mod = 0;
var ch_mod = 0;
var it_mod = 0;
var red = Color("ff0000");
var green = Color("00ff00");

onready var st_output = get_node("RichTextLabel");
onready var ag_output = get_node("RichTextLabel1");
onready var ch_output = get_node("RichTextLabel2");
onready var it_output = get_node("RichTextLabel3");

func _ready():
	add_item("-Select a Base Class-",0);
	set_item_disabled(0,true);
	add_separator();
	
	add_item("Fighter",1);
	add_item("Rogue",2);
	add_item("Bard",3);
	add_item("Mage",4);
	set_process(true);
	
func _process(delta):
	
	var st_tmp = st_output.get_bbcode();
	var ag_tmp = ag_output.get_bbcode();
	var ch_tmp = ch_output.get_bbcode();
	var it_tmp = it_output.get_bbcode();
	
	if (st_tmp == "0"):
		st_output.set_visible_characters(0);
	else:
		st_output.set_visible_characters(255);
		if(st_tmp.to_int() < 0):
			st_output.add_color_override("default_color", red);
		else:
			st_output.add_color_override("default_color", green);
	st_output.set_bbcode(str(st_mod));
	
	if (ag_tmp == "0"):
		ag_output.set_visible_characters(0);
	else:
		ag_output.set_visible_characters(255);
		if(ag_tmp.to_int() < 0):
			ag_output.add_color_override("default_color", red);
		else:
			ag_output.add_color_override("default_color", green);
	ag_output.set_bbcode(str(ag_mod));
	
	if (ch_tmp == "0"):
		ch_output.set_visible_characters(0);
	else:
		ch_output.set_visible_characters(255);
		if(ch_tmp.to_int() < 0):
			ch_output.add_color_override("default_color", red);
		else:
			ch_output.add_color_override("default_color", green);
	ch_output.set_bbcode(str(ch_mod));
	
	if (it_tmp == "0"):
		it_output.set_visible_characters(0);
	else:
		it_output.set_visible_characters(255);
		if(it_tmp.to_int() < 0):
			it_output.add_color_override("default_color", red);
		else:
			it_output.add_color_override("default_color", green);
	it_output.set_bbcode(str(it_mod));
	
	if(get_selected_ID()==1):
		st_mod = 2;
		ag_mod = 1;
		ch_mod = 0;
		it_mod = -1;
		main.sClass = {st_mod = st_mod, ag_mod = ag_mod, ch_mod = ch_mod, it_mod = it_mod};
		main.class_has_been_chosen = true;
	
	if(get_selected_ID()==2):
		st_mod = 0;
		ag_mod = 2;
		ch_mod = 1;
		it_mod = 0;
		main.sClass = {st_mod = st_mod, ag_mod = ag_mod, ch_mod = ch_mod, it_mod = it_mod};
		main.class_has_been_chosen = true;
	
	if(get_selected_ID()==3):
		st_mod = -1;
		ag_mod = 0;
		ch_mod = 3;
		it_mod = 1;
		main.sClass = {st_mod = st_mod, ag_mod = ag_mod, ch_mod = ch_mod, it_mod = it_mod};
		main.class_has_been_chosen = true;
	
	if(get_selected_ID()==4):
		st_mod = 0;
		ag_mod = 0;
		ch_mod = 0;
		it_mod = 3;
		main.sClass = {st_mod = st_mod, ag_mod = ag_mod, ch_mod = ch_mod, it_mod = it_mod};
		main.class_has_been_chosen = true;
	