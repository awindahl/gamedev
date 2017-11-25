extends StaticBody2D

var weaponNum = 1

func _ready():
	set_meta("Type", "Weapon")

func _getWeaponNum():
	return weaponNum