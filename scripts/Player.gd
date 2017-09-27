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
onready var timer = get_node("invin_timer")

func _ready():
	set_meta("Damaged", "False")
	set_meta("Type", "Player")
	look.add_exception(self)
	set_fixed_process(true)

func _on_player_hit():
	
	set_meta("Damaged", "True")
	move(direction*-1*SPEED*15)
	sprite.set_opacity(0.5)
	timer.start()
	

func _fixed_process(delta):
	
	if self.is_colliding():

		if get_collider().get_meta("Type") == "Enemy" && self.get_meta("Damaged") == "False":
			var play_hit = get_parent().get_node("Player")
			play_hit._on_player_hit()

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
	

func _on_invin_timer_timeout():
	set_meta("Damaged", "False")
	sprite.set_opacity(1)