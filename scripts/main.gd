extends Node

var myName;
var mySprite;
var myInventory;
var myExp;
var myLevel;
var myAbilities;
var myMC;
var myHp;
var myMp;
var i = 0;




var strength = 0;
var agility = 0;
var charisma = 0;
var intellect = 0;

var class_has_been_chosen = false;
var dice_has_been_rolled = false;
var all_skills_chosen = false;
var name_has_been_entered = false;

var sClass = {st_mod = 0, ag_mod = 0, ch_mod = 0, it_mod = 0};

var skillList = [
	"acrobatics", "climb", "diplomacy", "disguise", "disable_trap", "play_instrument", "jump", "listen",
	"stealth", "open_lock", "detect_trap", "ride", "search", "nat_knowl", "swim", "tumble", "use_rope",
	"first_aid", "detect_magic", "perception", "arcane_knowl", "forgery", "fletching", "smithing",
	"pickpocket", "religion"
];

var sSkills = [0,1,2]; # selected skills
var pSkills = [0,1,2]; # picked skills

var myClass = [];

var current_scene = null;

func _ready():
	var dir = Directory.new()
	if !dir.dir_exists("user://Saves"):
		dir.open("user://")
		dir.make_dir("user://Saves")

	
	var root = get_parent();
	current_scene = root.get_child( root.get_child_count() -1 );
	
func _save():
	var savedict = {
		"Strength" : myClass[0],
		"Agility"  : myClass[1],
		"Charisma" : myClass[2],
		"Intellect": myClass[3],
		"Skills"   : [myClass[4], myClass[5], myClass[6]],
		"Name"     : myName,
		"mySprite" : mySprite,
		"Inventory": myInventory,
		"Exp"      : myExp,
		"Level"    : myLevel,
		"Abilities": myAbilities,
		"MisCom"   : myMC,
		"HP"       : myHp,
		"MP"       : myMp
	}
	return savedict;

func _save_game_state(var saveName):
	var saveGame = File.new();
	if saveGame.file_exists("user://Saves/"+saveName+".sve"):
		i = i + 1;
		if saveGame.file_exists("user://Saves/"+saveName+".sve"):
			i = i + 1;
			saveGame.open("user://Saves/"+saveName+var2str(i)+".sve", File.WRITE);
		else:
			saveGame.open("user://Saves/"+saveName+var2str(i)+".sve", File.WRITE);
	else:
		saveGame.open("user://Saves/"+saveName+".sve", File.WRITE);
	
	var data = _save();
	var err = saveGame.open_encrypted_with_pass("user://Saves/"+saveName+".sve", File.WRITE, "cockmuncher")
	saveGame.store_line(data.to_json());
	saveGame.close();

func _load_game_state():
	pass
	
	