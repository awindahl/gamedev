
extends KinematicBody2D

var s = seed(randi())

# travel speed in pixel/s
export var speed = 4
onready var end = get_node("Position2D")
onready var timer = get_node("walk_time")
onready var collider = get_node("CollisionShape2D")
var start_pos = self.get_pos()

# at which distance to stop moving
# NOTE: setting this value too low might result in jerky movement near destination
const eps = 2

# points in the path
var points = []

func _ready():
	randomize(s)
	set_meta("Type", "Enemy")
	set_process(true)

func _process(delta):
	
	if self.is_colliding():
		if get_collider().get_meta("Type") == "Player":
			var node = get_parent().get_node("Player")
			node._on_player_hit()
	
	# refresh the points in the path
	points = get_node("../Navigation2D").get_simple_path(get_global_pos(), end.get_global_pos(), false)
	
	# if the path has more than one point
	if points.size() > 1:
		var distance = points[1] - get_global_pos()
		var direction = distance.normalized() # direction of movement
		if distance.length() > eps:
			if floor(timer.get_time_left()) < 1:
				move(Vector2(direction.x*speed,0))
			else:
				move(Vector2(0,direction.y*speed))
		else:
			move(Vector2(0,0)) # close enough - stop moving
		update() # we update the node so it has to draw it self again

func _on_Timer_timeout():
	self.move(Vector2(0,0))
	var i = rand_range(-100.0,100.0)*10
	var j = rand_range(-100.0,100.0)*10
	end.set_pos(Vector2(i,j))
