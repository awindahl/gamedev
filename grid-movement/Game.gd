extends Node

onready var e = get_node("Enemy1")
onready var end_pos = get_node("EndPos")
onready var nav = get_node("nav")
onready var start_pos = get_node("StartPos").get_pos()


func _ready():
	set_process_input(true)
	set_process(true)
	set_pause_mode(PAUSE_MODE_PROCESS)

func _input(event):
	if event.is_action_pressed("pause"):
		if get_tree().is_paused():
			get_tree().set_pause(false)
		else:
			get_tree().set_pause(true)


func _process(delta):
	
	if !e.hasReached:
		e.goal = end_pos.get_pos()
		e.nav = nav
	else:
		var i = rand_range(1.0,20.0)
		end_pos.set_pos(Vector2(i,i))
		e.hasReached=false