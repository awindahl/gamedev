extends KinematicBody2D

var direction = Vector2()
var start_pos = Vector2()

var is_attacking = false

var coolDown = 0
var attack_timer = 0
const SPEED = 4

onready var world = get_world_2d().get_direct_space_state()

onready var look = get_node("Looking")
onready var sprite = get_node("Sprite")
onready var collider = get_node("CollisionShape2D")
onready var timer = get_node("invin_timer")

func _ready():
	set_meta("Type", "Player")
	look.add_exception(self)
	set_fixed_process(true)

func _fixed_process(delta):
	
	if self.is_colliding():
		if get_collider().get_meta("Type") == "Enemy":
			move(direction*-1*SPEED*10)
			sprite.set_modulate(55)
			collider.set_trigger(true)
			timer.start()

	#-------Handles Strafing Control
	if Input.is_action_pressed("move_up") && !is_attacking:
		look.set_rot(deg2rad(180))
	elif Input.is_action_pressed("move_down") && !is_attacking:
		look.set_rot(deg2rad(0))
	elif Input.is_action_pressed("move_left") && !is_attacking:
		look.set_rot(deg2rad(270))
	elif Input.is_action_pressed("move_right") && !is_attacking:
		look.set_rot(deg2rad(90))

	#-------Handles Movement-------#
	if Input.is_action_pressed("move_up"):
		direction = Vector2(0,-1)
		move(direction * SPEED)
	elif Input.is_action_pressed("move_down"):
		direction = Vector2(0,1)
		move(direction * SPEED)
	if  Input.is_action_pressed("move_left"):
		direction = Vector2(-1,0)
		move(direction * SPEED)
	elif  Input.is_action_pressed("move_right"):
		direction = Vector2(1,0)
		move(direction * SPEED)

	#-----Handles Attacking-------#
	if coolDown > 0:
		coolDown -= 1
	else:
		look.set_enabled(false)
		look.get_child(0).hide()
	
	if is_attacking:
		attack_timer -= 1
		if attack_timer == 0:
			is_attacking = false
	
	if !is_attacking && Input.is_action_pressed("ui_select"):
		is_attacking = true
		attack_timer = 7
		coolDown = 5
		look.set_enabled(true)
		look.get_child(0).show()
	elif is_attacking && Input.is_action_pressed("ui_select"):
		look.get_child(0).show()
		look.set_enabled(true)


func _on_invin_timer_timeout():
	collider.set_trigger(false)
	sprite.set_modulate(255)