extends Node

var strength = 0;
var agility = 0;
var charisma = 0;
var intellect = 0;

var sClass = {st_mod = 0, ag_mod = 0, ch_mod = 0, it_mod = 0};

var sSkills = {};

var current_scene = null

func _ready():
	var root = get_parent();
	current_scene = root.get_child( root.get_child_count() -1 )
	