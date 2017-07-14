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
var myFile;
var tempNameSave;

var mySave1;
var mySave2;
var mySave3;

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

# ----- Initial screen settings -----
	OS.set_window_position(OS.get_screen_size(OS.get_current_screen())/2-(OS.get_window_size()/2))
	OS.set_window_resizable(false)
	OS.set_window_title("Game: the game")
	
	
	print(OS.get_data_dir())
# ----- Load saves if game_data exists -----
	var game_data = File.new();
	if game_data.file_exists("res://game_data.sve"):
		var current_line = {}
		game_data.open("res://game_data.sve", File.READ)
		while (!game_data.eof_reached()):
			current_line.parse_json(game_data.get_line())
			mySave1 = current_line["file1"]
			mySave2 = current_line["file2"]
			mySave3 = current_line["file3"]
	else:
		var files = _game_data();
		game_data.open("res://game_data.sve", File.WRITE)
		game_data.store_line(files.to_json());
	game_data.close();
	
# ----- Check for saves directory -----
	var dir = Directory.new()
	if !dir.dir_exists("user://Saves/"):
		dir.open("user://")
		dir.make_dir("user://Saves")
		dir.make_dir("user://Saves/Rpg")
	#-- if Saves folder already exists --
	if !dir.dir_exists("user://Saves/Rpg"):
		dir.open("user://Saves")
		dir.make_dir("user://Saves/Rpg")

# ----- Check if saves loaded in game_data actually exists -----
	
	var findGame = File.new();
	if mySave1:
		if !findGame.file_exists("user://Saves/Rpg/"+mySave1+".sve"):
			mySave1 = null
	if mySave2:
		if !findGame.file_exists("user://Saves/Rpg/"+mySave2+".sve"):
			mySave2 = null
	if mySave3:
		if !findGame.file_exists("user://Saves/Rpg/"+mySave3+".sve"):
			mySave3 = null
	findGame.close()
	
	var root = get_parent();
	current_scene = root.get_child( root.get_child_count() -1 );
	
func _save():
	var savedict = {
		"File"	   : myFile,
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

func _game_data():
	var datadict = {
		"file1" : mySave1,
		"file2" : mySave2,
		"file3" : mySave3
	}
	return datadict;

func _update_game_data():
	var saveGameInfo = File.new();
	var data = _game_data();
	saveGameInfo.open("res://game_data.sve", File.WRITE);
	saveGameInfo.store_line(data.to_json());
	saveGameInfo.close();

func _save_game_state(var saveName):
	var saveGame = File.new();
	var saveGameInfo = File.new();
	if saveGame.file_exists("user://Saves/Rpg/"+saveName+".sve"):
		i = i + 1;
		if saveGame.file_exists("user://Saves/Rpg/"+saveName+".sve"):
			i = i + 1;
			saveGame.open("user://Saves/Rpg/"+saveName+var2str(i)+".sve", File.WRITE);
			tempNameSave = saveName+var2str(i)
		else:
			saveGame.open("user://Saves/Rpg/"+saveName+var2str(i)+".sve", File.WRITE);
			tempNameSave = saveName+var2str(i)
	else:
		saveGame.open("user://Saves/Rpg/"+saveName+".sve", File.WRITE);
		tempNameSave = saveName
	
	var data = _save();
	
	if data["File"] == 1:
		mySave1 = tempNameSave
	elif data["File"] == 2:
		mySave2 = tempNameSave
	elif data["File"] == 3:
		mySave3 = tempNameSave
		
	saveGameInfo.open("res://game_data.sve", File.WRITE);
	var data2 = _game_data();
	
	#EKIN HELP var err = saveGame.open_encrypted_with_pass("user://Saves/Rpg/"+saveName+".sve", File.WRITE, "cockmuncher")

	saveGame.store_line(data.to_json());
	saveGameInfo.store_line(data2.to_json());
	saveGame.close();
	saveGameInfo.close();

func _load_game_state(var saveName):
	print(saveName)
	if saveName == null:
		pass
	else:
		myClass.resize(7);
		var current_line = {}
		var load_data = File.new();
		#EKIN HELP var err = load_data.open_encrypted_with_pass("user://Saves/Rpg/"+saveName+".sve", File.READ, "cockmuncher")
		load_data.open("user://Saves/Rpg/"+saveName+".sve", File.READ)
		while !(load_data.eof_reached()):
			current_line.parse_json(load_data.get_line())
			myFile = current_line["File"]
			myClass[0] = current_line["Strength"]
			myClass[1] = current_line["Agility"]
			myClass[2] = current_line["Charisma"]
			myClass[3] = current_line["Intellect"]
			[myClass[4], myClass[5], myClass[6]] = current_line["Skills"]
			myName = current_line["Name"]
			mySprite = current_line["mySprite"]
			myInventory = current_line["Inventory"]
			myExp = current_line["Exp"]
			myLevel = current_line["Level"]
			myAbilities = current_line["Abilities"]
			myMC = current_line["MisCom"]
			myHp = int(current_line["HP"])
			myMp = int(current_line["MP"])
		load_data.close()
		myClass.empty();

	
func _delete_save(var saveName):
	print("delete: "+saveName)
	var deleteSave = Directory.new()
	deleteSave.remove("user://Saves/Rpg/"+saveName+".sve")