extends Node2D

var selectedWeapon = "Unarmed"

func _ready():
	set_meta("Type", "Weapon")
	print("weaponclass ready")
	
func _attacking():
	#get collision data and send damage to game.gd
	print("attacking with ", selectedWeapon)
	get_node(selectedWeapon).show()
	
func _hideAttack():
	get_node(selectedWeapon).set_hidden(true)
	

func _swapPattern(playerWeapon):
	#first hide all
	for i in range (self.get_child_count()):
		get_node(self.get_child(i).get_name()).hide()
		print(self.get_child(i).get_name())
	#then select new pattern
	selectedWeapon = playerWeapon
