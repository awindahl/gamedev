extends StaticBody2D

export(int, "Unarmed","Sword", "Hammer")  var weaponNum
var weaponArr = ["Weapon_Sword.png","Weapon_Hammer.png"]

var weaponSpeed = 0.5

func _ready():
	set_meta("Type", "Weapon")
	get_node("WeaponPickup").set_texture(load("res://grid-movement/tilesets/mines/" + weaponArr[weaponNum-1])) 
	
func _getWeaponNum():
	return 1 #weaponNum after we fix

func _getWeaponSpeed():
	return weaponSpeed
