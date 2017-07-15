extends RigidBody2D

export var speed = 200
export var  is_x = false
export var  is_y = false

onready var look_ahead = get_node("RayCast2D")
onready var timer = get_node("Timer")

func _ready():
	set_meta("Type", "Enemy")
	set_process(true)
	
func _process(delta):
	
	if is_x && !look_ahead.is_colliding() && floor(timer.get_time_left()) == 1 && get_linear_velocity().y == 0:
		set_axis_velocity(Vector2(speed*direction,0))
	if is_y && !look_ahead.is_colliding() && floor(timer.get_time_left()) == 1 && get_linear_velocity().x == 0:
		set_axis_velocity(Vector2(speed*direction,10))