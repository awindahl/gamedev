extends Node

var myName;
var mySprite;
var myInventory;
var myWep = ["",""]; #0 primary, 1 secondary
var myEquip = ["","Shirt","Pants","Shoes","",""]; #0 head, 1 torso, 2 legs, 3 feet, 4 hands, 5 back
var myExp;
var myLevel;
var myAbilities;
var myMC;
var myHp;
var myMp;
var myStr;
var myAgi;
var myCha;
var myInt;
var myFile;
var tempNameSave;
var myFeat = ["","",""];
var myClass;

var mySave1;
var mySave2;
var mySave3;

var strength = 0;
var agility = 0;
var charisma = 0;
var intellect = 0;

var current_scene = null;

func _ready():
# ----- Initial screen settings -----
	OS.set_window_position(OS.get_screen_size(OS.get_current_screen())/2-(OS.get_window_size()/2))
	OS.set_window_resizable(false)
	OS.set_window_title("Game: the game")
	OS.set_target_fps(60)
	
	
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
	
	current_scene = get_parent().get_child( get_parent().get_child_count() -1 );
	
func _save():
	var savedict = {
		"File"	   : myFile,
		"Strength" : myStr,
		"Agility"  : myAgi,
		"Charisma" : myCha,
		"Intellect": myInt,
		"Feats"    : [ myFeat[0], myFeat[1], myFeat[2]],
		"Weapon"   : [ myWep[0], myWep[1]],
		"Equip"    : [ myEquip[0], myEquip[1], myEquip[2], myEquip[3], myEquip[4], myEquip[5]],
		"Name"     : myName,
		"mySprite" : mySprite,
		"Inventory": myInventory,
		"Exp"      : myExp,
		"Level"    : myLevel,
		"Abilities": myAbilities,
		"MisCom"   : myMC,
		"HP"       : myHp,
		"MP"       : myMp,
		"Class"    : myClass
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
	
	var existing = false;
	var addToFile = "";
	var count = 0;
	
	if saveGame.file_exists("user://Saves/Rpg/"+saveName+".sve"):
		existing = true
	else:
		saveGame.open("user://Saves/Rpg/"+saveName+".sve", File.WRITE);
		tempNameSave = saveName;
		
	while existing:
		count += 1;
		if not saveGame.file_exists("user://Saves/Rpg/"+saveName+var2str(count)+".sve"):
			addToFile = var2str(count)
			saveGame.open("user://Saves/Rpg/"+saveName+addToFile+".sve", File.WRITE);
			tempNameSave = saveName+addToFile;
			existing = false;
	
	var data = _save();
	
	if data["File"] == 1:
		mySave1 = tempNameSave
	elif data["File"] == 2:
		mySave2 = tempNameSave
	elif data["File"] == 3:
		mySave3 = tempNameSave
		
	saveGameInfo.open("res://game_data.sve", File.WRITE);
	var data2 = _game_data();
	
	saveGame.open_encrypted_with_pass("user://Saves/Rpg/"+saveName+".sve", File.WRITE, "test") #in the future, lock with OS.get_unique_ID()

	saveGame.store_line(data.to_json());
	saveGameInfo.store_line(data2.to_json());
	saveGame.close();
	saveGameInfo.close();

func _load_game_state(var saveName):
	print(saveName)
	if saveName == null:
		pass
	else:
		var current_line = {}
		var load_data = File.new();

		load_data.open_encrypted_with_pass("user://Saves/Rpg/"+saveName+".sve", File.READ, "test") #in the future, open with OS.get_unique_ID()
		
		while !(load_data.eof_reached()):
			current_line.parse_json(load_data.get_line())
			print(current_line)
			
		myFile = current_line["File"]
		myStr = current_line["Strength"]
		myAgi = current_line["Agility"]
		myCha = current_line["Charisma"]
		myInt = current_line["Intellect"]
		myFeat = current_line["Feats"]
		myWep = current_line["Weapon"]
		myEquip = current_line["Equip"]
		myName = current_line["Name"]
		mySprite = current_line["mySprite"]
		myInventory = current_line["Inventory"]
		myExp = current_line["Exp"]
		myLevel = current_line["Level"]
		myAbilities = current_line["Abilities"]
		myMC = current_line["MisCom"]
		myHp = int(current_line["HP"])
		myMp = int(current_line["MP"])
		myClass = current_line["Class"]
		load_data.close()
	
func _delete_save(var saveName):
	print("delete: "+saveName)
	var deleteSave = Directory.new()
	deleteSave.remove("user://Saves/Rpg/"+saveName+".sve")