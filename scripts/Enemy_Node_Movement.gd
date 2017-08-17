
extends RigidBody2D

var s = seed(randi())

# travel speed in pixel/s
export var speed = 200
onready var end = get_node("Position2D")
onready var timer = get_node("walk_time")
var start_pos = self.get_pos()

# at which distance to stop moving
# NOTE: setting this value too low might result in jerky movement near destination
const eps = 5

# points in the path
var points = []

func _ready():
	randomize(s)
	set_meta("Type", "Enemy")
	set_fixed_process(true)

func _fixed_process(delta):
	# refresh the points in the path
	points = get_node("../Navigation2D").get_simple_path(get_global_pos(), end.get_global_pos(), false)
	
	# if the path has more than one point
	if points.size() > 1:
		var distance = points[1] - get_global_pos()
		var direction = distance.normalized() # direction of movement
		if distance.length() > eps or points.size() > 2:
			set_linear_velocity(direction*speed)
		else:
			set_linear_velocity(Vector2(0, 0)) # close enough - stop moving
		update() # we update the node so it has to draw it self again

func _on_Timer_timeout():
	var i = rand_range(-200.0,200.0)
	var j = rand_range(-200.0,200.0)
	end.set_pos(Vector2(i,j))
