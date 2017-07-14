
extends Sprite

var speed = 150
var nav = null setget set_nav
var path  = []
onready var goal = Vector2()
var hasReached = false

func _ready():

	self.set_meta("Type" , "Enemy")
	set_fixed_process(true)
	
func set_nav(new_nav):
	nav = new_nav
	update_path()

func update_path():
	
	path = nav.get_simple_path(get_pos(), goal, false)
	#if path.size() == 0:
	#	queue_free()

func _fixed_process(delta):
	
	if path.size() > 1:
		
		var d = get_pos().distance_to(path[1])
		d = floor(d)
		if d > 0:
			set_pos(get_pos().linear_interpolate(path[1], (speed * delta)/d))
		else:
			hasReached = true;
			path.remove(0)
			print(path.size())
			