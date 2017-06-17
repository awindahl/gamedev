extends KinematicBody2D

var direction = Vector2()

const MAX_SPEED = 400

var speed = 0
var velocity = Vector2()

var target_pos = Vector2()
var target_direction = Vector2()
var is_moving = false

var type
var grid

onready var attack = get_node("Attack");
var attack_wait = 0
var attack_val = 0

func _ready():
	grid = get_parent()
	type = grid.PLAYER
	set_fixed_process(true)


func _fixed_process(delta):
	direction = Vector2()
	speed = 0

	if Input.is_action_pressed("move_up") && attack_val == 0:
		direction.y = -1
	elif Input.is_action_pressed("move_down") && attack_val == 0:
		direction.y = 1
	elif Input.is_action_pressed("move_left") && attack_val == 0:
		direction.x = -1
	elif Input.is_action_pressed("move_right") && attack_val == 0:
		direction.x = 1

	if not is_moving and direction != Vector2():
		target_direction = direction.normalized()
		if grid.is_cell_vacant(get_pos(), direction):
			target_pos = grid.update_child_pos(get_pos(), direction, type)
			is_moving = true
	elif is_moving:
		speed = MAX_SPEED
		velocity = speed * target_direction * delta

		var pos = get_pos()
		var distance_to_target = pos.distance_to(target_pos)
		var move_distance = velocity.length()

		if move_distance > distance_to_target:
			velocity = target_direction * distance_to_target
			is_moving = false
		
		move(velocity)
	
	if Input.is_action_pressed("ui_accept") && attack_val == 0 && attack_wait == 0:
		attack_wait = 20
		attack.show()
		attack_val = 30
		attack.set_pos(target_direction * 60);
	
	if attack_val < 101 && attack_val > 0:
		attack_val-=1
	
	if attack_val == 0 && attack_wait > 0:
		attack.hide()
		attack_wait -= 1
	