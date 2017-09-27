extends KinematicBody2D

export var speed = 4
export var  is_x = false
export var  is_y = false
export var  is_contained = false

onready var look_x = get_node("XLOOK")
onready var look_y = get_node("YLOOK")
onready var timer = get_node("WalkTimer")
onready var container = get_node("ContainedTimer")

var direction = Vector2(1,-1)
var xmove = false
var ymove = false


func _ready():
	look_x.add_exception(self)
	look_y.add_exception(self)
	set_meta("Type", "Enemy")
	set_process(true)
	
func _process(delta):
	
	if self.is_colliding():
		if get_collider().get_meta("Type") == "Player" && get_collider().get_meta("Damaged") == "False":
			var play_hit = get_parent().get_node("Player")
			play_hit._on_player_hit()

	if look_x.is_colliding() && (look_x.get_collider().get_meta("Type") == "Map" || "Player" || look_x.get_collider().get_meta("Type") == "Enemy"):
		look_x.rotate(deg2rad(180))
		direction.x = direction.x * - 1
		
	if look_y.is_colliding() && (look_y.get_collider().get_meta("Type") == "Map" || "Player" || look_y.get_collider().get_meta("Type") == "Enemy"):
		look_y.rotate(deg2rad(180))
		direction.y = direction.y * - 1
	
	if is_x:
		if floor(timer.get_time_left()) == 2:
			move(Vector2(speed * direction.x, 0))
			xmove = true
		elif !ymove:
			xmove = false
			move(Vector2(0,0))
	if is_y:
		if floor(timer.get_time_left()) == 0:
			move(Vector2(0,speed * direction.y))
			ymove = true
		elif !xmove:
			move(Vector2(0,0))
			ymove = false
			
	
func _on_ContainedTimer_timeout():
	print("IM TIMED OUT ASSHOLE")
	look_x.rotate(deg2rad(180))
	look_y.rotate(deg2rad(180))
	direction = direction * -1