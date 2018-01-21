extends Node2D

var weapons = ["Unarmed", "Sword", "Hammer"]
var selectedWeapon = weapons[0]
var damage = 10

func _ready():
	set_meta("Type", "Weapon")
	print("weaponclass ready")

func _attacking():
	print("Hitting with ", selectedWeapon, " for ", damage, " damage.")
	get_node(selectedWeapon).show()
	get_node(selectedWeapon).set_enable_monitoring(true)

func _hideAttack():
	for N in self.get_children():
		N.set_hidden(true)
	get_node(selectedWeapon).set_hidden(true)
	get_node(selectedWeapon).set_enable_monitoring(false)

func _getSelectedWeapon():
	return selectedWeapon

func _setSelectedWeapon(n):
	selectedWeapon = weapons[n]
	
func _setSelectedDamage(n):
	damage = n

func _on_body_enter( body ):
	print(body.get_meta("Type"))
	if body.get_meta("Type") == "Enemy" && body.get_meta("Damaged") == "False":
		var test = get_world_2d().get_direct_space_state().intersect_point(body.get_pos(),1)
		get_parent().get_parent().get_parent()._calculate_damage(test[0].collider,damage)
	else:
		if body.get_meta("Type") == "NPC":
			print("why would you do this?")
		pass