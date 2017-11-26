extends Node2D

var weapons = ["Unarmed", "Sword"]
var selectedWeapon = weapons[0]
var damage = 10

func _ready():
	set_meta("Type", "Weapon")
	print("weaponclass ready")

func _attacking():
	print("attacking with ", selectedWeapon)
	get_node(selectedWeapon).show()
	get_node(selectedWeapon).set_enable_monitoring(true)

func _hideAttack():
	for N in self.get_children():
		N.set_hidden(true)
	get_node(selectedWeapon).set_hidden(true)
	get_node(selectedWeapon).set_enable_monitoring(false)

func _swapPattern(playerWeapon):
	#first hide all
	for i in range (self.get_child_count()):
		get_node(self.get_child(i).get_name()).hide()
		print(self.get_child(i).get_name())
	#then select new pattern
	selectedWeapon = playerWeapon

func _getSelectedWeapon():
	return selectedWeapon

func _setSelectedWeapon(n):
	selectedWeapon = weapons[n]

func _on_Sword_body_enter( body ):
	print(body.get_meta("Type"))
	if body.get_meta("Type") == "Enemy":
		var test = get_world_2d().get_direct_space_state().intersect_point(body.get_pos(),1)
		get_parent().get_parent().get_parent()._calculate_damage(test[0].collider,damage)

func _on_Unarmed_body_enter( body ):
	print(body.get_meta("Type"))
	