
extends KinematicBody2D

var s = seed(randi())

# travel speed in pixel/s
export var speed = 4
var ct_speed = speed
export var damage = 10
export var hp = 30

onready var end = get_node("Position2D")
onready var timer = get_node("walk_time")
onready var collider = get_node("CollisionShape2D")
var start_pos = self.get_pos()
var direction
onready var sprite = get_node("Sprite")
onready var invinTimer = get_node("InvinTimer")

# at which distance to stop moving
# NOTE: setting this value too low might result in jerky movement near destination
const eps = 2

# points in the path
var points = []

func _ready():
	randomize(s)
	set_meta("Type", "Enemy")
	set_meta("Damaged", "False")
	set_process(true)

func _process(delta):
	
	if hp < 1:
		hide()
		#translate(Vector2(-500,-500))
		self.queue_free()
		
	if self.is_colliding():
		if get_collider().get_meta("Type") == "Player" && get_collider().get_meta("Damaged") == "False":
			var test = get_world_2d().get_direct_space_state().intersect_point(get_collider().get_pos(),1)
			get_parent()._calculate_damage(test[0].collider,damage)
	
	# refresh the points in the path
	points = get_node("../Navigation2D").get_simple_path(get_global_pos(), end.get_global_pos(), false)
	var distance = points[1] - get_global_pos()
	direction = distance.normalized() # direction of movement
	
	# check if colliding with player
	if self.is_colliding():
		if get_collider().get_meta("Type") == "Player" && get_collider().get_meta("Damaged") == "False":
			var play_hit = get_parent().get_node("Player")
			play_hit._on_player_hit()
		else: 
			1+1
	
	# if the path has more than one point
	if points.size() > 1:
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

func _on_InvinTimer_timeout():
	set_meta("Damaged", "False")
	sprite.set_opacity(1)
	speed = ct_speed