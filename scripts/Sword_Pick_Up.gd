extends StaticBody2D

var weaponNum = 1
var weaponSpeed = 0.5

func _ready():
	set_meta("Type", "Weapon")

func _getWeaponNum():
	return weaponNum

func _getWeaponSpeed():
	return weaponSpeed