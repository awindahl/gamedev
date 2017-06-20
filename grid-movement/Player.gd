extends KinematicBody2D

var direction = Vector2()
var start_pos = Vector2()

var is_moving = false

const GRID = 64
const SPEED = 4

onready var world = get_world_2d().get_direct_space_state()

onready var look = get_node("Looking")

func _ready():
	look.add_exception(self)
	set_fixed_process(true)

func _fixed_process(delta):
	
	#-------Handles looking control-----#
	if Input.is_action_pressed("move_up"):
		look.set_rot(deg2rad(180))
	elif Input.is_action_pressed("move_down"):
		look.set_rot(deg2rad(0))
	elif Input.is_action_pressed("move_left"):
		look.set_rot(deg2rad(240))
	elif Input.is_action_pressed("move_right"):
		look.set_rot(deg2rad(90))
	
	#-------Handles grid movement-------#
	if !is_moving:
		
		var resultUp = world.intersect_point(get_pos() + Vector2(0, -GRID))
		var resultDown = world.intersect_point(get_pos() + Vector2(0, GRID))
		var resultLeft = world.intersect_point(get_pos() + Vector2(-GRID, 0))
		var resultRight = world.intersect_point(get_pos() + Vector2(GRID, 0))
		
		if Input.is_action_pressed("move_up") && resultUp.empty():
			is_moving=true
			direction = Vector2(0,-1)
			start_pos=get_pos()
		elif Input.is_action_pressed("move_down") && resultDown.empty():
			is_moving=true
			direction = Vector2(0,1)
			start_pos=get_pos()
		elif  Input.is_action_pressed("move_left") && resultLeft.empty():
			is_moving=true
			direction = Vector2(-1,0)
			start_pos=get_pos()
		elif  Input.is_action_pressed("move_right") &&resultRight.empty():
			is_moving=true
			direction = Vector2(1,0)
			start_pos=get_pos()
	else:
		move_to(get_pos() + direction * SPEED)
		if get_pos() == start_pos +Vector2(GRID*direction.x, GRID*direction.y):
			is_moving = false