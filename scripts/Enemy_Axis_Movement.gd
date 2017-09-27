extends KinematicBody2D

var s = seed(randi())

export var speed = 4
export var  is_x = false
export var  is_y = false
export var  is_contained = false

onready var look_x = get_node("XLOOK")
onready var look_y = get_node("YLOOK")
onready var timer = get_node("WalkTimer")
onready var container = get_node("ContainedTimer")

var direction = Vector2(1,-1)
var xlessthan = randi()%3
var ylessthan = randi()%3
var xmove = false
var ymove = false


func _ready():
	randomize(s)
	look_x.add_exception(self)
	look_y.add_exception(self)
	set_meta("Type", "Enemy")
	container.set_wait_time(randi()%5+1)
	timer.set_wait_time(randi()%4+1)
	set_process(true)
	
func _process(delta):
	
	if ylessthan == xlessthan:
		ylessthan = ylessthan + 1
	
	if self.is_colliding():
		if get_collider().get_meta("Type") == "Player" && get_collider().get_meta("Damaged") == "False":
			var play_hit = get_parent().get_node("Player")
			play_hit._on_player_hit(direction)

	if look_x.is_colliding() && (look_x.get_collider().get_meta("Type") == "Map" || look_x.get_collider().get_meta("Type") == "Enemy"):
		look_x.rotate(deg2rad(180))
		direction.x = direction.x * - 1
		
	if look_y.is_colliding() && (look_y.get_collider().get_meta("Type") == "Map" || look_y.get_collider().get_meta("Type") == "Enemy"):
		look_y.rotate(deg2rad(180))
		direction.y = direction.y * - 1
	
	if is_x:
		if floor(timer.get_time_left()) == xlessthan:
			move(Vector2(speed * direction.x, 0))
			xmove = true
		elif !ymove:
			xmove = false
			move(Vector2(0,0))
	if is_y:
		if floor(timer.get_time_left()) == ylessthan:
			move(Vector2(0,speed * direction.y))
			ymove = true
		elif !xmove:
			move(Vector2(0,0))
			ymove = false
			
	
func _on_ContainedTimer_timeout():
	xlessthan = randi()%3
	ylessthan = randi()%3
	if ylessthan == xlessthan:
		ylessthan = ylessthan + 1
	
	look_x.rotate(deg2rad(180))
	look_y.rotate(deg2rad(180))
	direction = direction * -1