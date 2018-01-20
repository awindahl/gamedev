extends StaticBody2D

export(int, "Unarmed","Sword", "Hammer")  var weaponNum
export(int) var damage = 10
export(float) var weaponSpeed = 0.5

var weaponArr = ["Weapon_Unarmed.png", "Weapon_Sword.png","Weapon_Hammer.png"]

func _ready():
	set_meta("Type", "Weapon")
	get_node("WeaponPickup").set_texture(load("res://Assets/Sprites/Mines/" + weaponArr[weaponNum])) 
	
func _getWeaponNum():
	return weaponNum #0 unarmed, 1 swrd, 2 hammer etc

func _getWeaponSpeed():
	return weaponSpeed

func _getWeaponDamage():
	return damage