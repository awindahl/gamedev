extends KinematicBody2D

var direction      = Vector2()

var coolDown       = 0
const SPEED        = 4

var isAttacking    = false
var canAttack      = true
var weaponType
onready var hp     = get_parent().myHp
onready var mp     = get_parent().myMp
var dmg
var equipType

onready var world  = get_world_2d().get_direct_space_state()

onready var look                = get_node("Looking")
onready var sprite              = get_node("Sprite")
onready var invincibilityTimer  = get_node("InvincibilityTimer")
onready var weapon              = get_node("Looking/WeaponBody")
onready var attackTimer         = get_node("AttackTimer")
onready var attackCoolDown      = get_node("AttackCoolDown")

func _ready():
	set_meta("Damaged", "False")
	set_meta("Type", "Player")
	look.add_exception(self)
	set_fixed_process(true)
	set_process_input(true)

func _on_player_hit():
	print("player:", self.get_instance_ID())
	set_meta("Damaged", "True")
	move (direction*-1*SPEED*15)
	sprite.set_opacity(0.5)
	invincibilityTimer.start()
	
func _fixed_process(delta):
	
	if self.is_colliding():
		if get_collider().get_meta("Type") == "Enemy" && self.get_meta("Damaged") == "False":
			var test = get_world_2d().get_direct_space_state().intersect_point(get_collider().get_pos(),1)
			get_parent()._calculate_damage(get_parent().get_node("Player"),test[0].collider.damage)
		elif get_collider().get_meta("Type") == "Weapon":
			weaponType = get_collider()._getWeaponNum()
			weapon._setSelectedWeapon(get_collider()._getWeaponNum())
			weapon._setSelectedDamage(get_collider()._getWeaponDamage())
			attackCoolDown.set_wait_time(get_collider()._getWeaponSpeed())
			get_collider().get_node("CollisionShape2D").set_trigger(true)
			get_collider().queue_free()
		elif get_collider().get_meta("Type") == "NPC" && Input.is_action_pressed("ui_action"):
			get_parent().get_node("gui").get_child(0).get_node("TextBox").show()
		else:
			pass
	
	#-------Handles Movement-------#
	if Input.is_action_pressed("move_up") && !isAttacking:
		look.set_rot(deg2rad(180))
		direction = Vector2(0,-1)
		move(direction * SPEED)
	if Input.is_action_pressed("move_down") && !isAttacking:
		look.set_rot(deg2rad(0))
		direction = Vector2(0,1)
		move(direction * SPEED)
	if  Input.is_action_pressed("move_left") && !isAttacking:
		look.set_rot(deg2rad(270))
		direction = Vector2(-1,0)
		move(direction * SPEED)
	if  Input.is_action_pressed("move_right") && !isAttacking:
		look.set_rot(deg2rad(90))
		direction = Vector2(1,0)
		move(direction * SPEED)

func _input(event):
	#-----Handles Attacking-------#
	if event.is_action_pressed("ui_accept") && !isAttacking && canAttack:
		isAttacking = true
		canAttack = false
		attackTimer.start()
		weapon._attacking()

func _on_InvincibilityTimer_timeout():
	set_meta("Damaged", "False")
	sprite.set_opacity(1)

func _on_AttackTimer_timeout():
	weapon._hideAttack()
	isAttacking = false
	attackCoolDown.start()

func _on_AttackCoolDown_timeout():
	print("Ready to attack!!")
	canAttack = true