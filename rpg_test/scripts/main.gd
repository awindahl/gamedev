extends Node

var strength = 0;
var agility = 0;
var charisma = 0;
var intellect = 0;

var class_has_been_chosen = false;
var dice_has_been_rolled = false;

var sClass = {st_mod = 0, ag_mod = 0, ch_mod = 0, it_mod = 0};

var skillList = [	
					"acrobatics", "climb", "diplomacy", "disguise", "disable_trap", "play_instrument", "jump", "listen", 
					"stealth", "open_lock", "detect_trap", "ride", "search", "nat_knowl", "swim", "tumble", "use_rope", 
					"first_aid", "detect_magic", "perception", "arcane_knowl", "forgery", "fletching", "smithing", 
					"pickpocket", "religion"
				];

var sSkills = []; # selected skills
var pSkills = []; # picked skills

var myClass = [];

var current_scene = null;

func _ready():
	var root = get_parent();
	current_scene = root.get_child( root.get_child_count() -1 );