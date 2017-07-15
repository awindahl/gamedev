extends RigidBody2D

export var speed = 200
export var  is_x = false
export var  is_y = false

onready var look_x = get_node("XLOOK")
onready var look_y = get_node("YLOOK")
onready var timer = get_node("Timer")
var direction = Vector2(1,-1)

func _ready():
	look_x.add_exception(self)
	look_y.add_exception(self)
	set_meta("Type", "Enemy")
	set_process(true)
	
func _process(delta):

	if look_x.is_colliding() && (look_x.get_collider().get_meta("Type") == "Map" || look_x.get_collider().get_meta("Type") == "Enemy"):
		look_x.rotate(deg2rad(180))
		direction.x = direction.x * - 1
		
	if look_y.is_colliding() && (look_y.get_collider().get_meta("Type") == "Map" || look_y.get_collider().get_meta("Type") == "Enemy"):
		look_y.rotate(deg2rad(180))
		direction.y = direction.y * - 1
	
	if is_x:
		if floor(timer.get_time_left()) == 2 &&  get_linear_velocity().y == 0:
			set_axis_velocity(Vector2(speed * direction.x, 0))
		else:
			set_linear_velocity(Vector2(0,0))
	if is_y:
		if floor(timer.get_time_left()) == 0 && get_linear_velocity().x == 0:
			set_axis_velocity(Vector2(0,speed * direction.y))
		else:
			set_linear_velocity(Vector2(0,0))