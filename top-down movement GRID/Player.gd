extends KinematicBody2D

var direction = Vector2()
var start_pos = Vector2()

var is_moving = false

const GRID = 64
const SPEED = 4

onready var look = get_node("Looking")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	
	if !is_moving && !look.is_colliding():
		if Input.is_action_pressed("move_up"):
			is_moving=true
			direction = Vector2(0,-1)
			start_pos=get_pos()
			look.set_rot(deg2rad(-180))
		elif Input.is_action_pressed("move_down"):
			is_moving=true
			direction = Vector2(0,1)
			start_pos=get_pos()
		elif  Input.is_action_pressed("move_left"):
			is_moving=true
			direction = Vector2(-1,0)
			start_pos=get_pos()
		elif  Input.is_action_pressed("move_right"):
			is_moving=true
			direction = Vector2(1,0)
			start_pos=get_pos()
	else:
		move_to(get_pos() + direction * SPEED)
		if get_pos() == start_pos +Vector2(GRID*direction.x, GRID*direction.y):
			is_moving = false