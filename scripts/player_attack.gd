
extends RayCast2D

func _ready():
	set_meta("Type" , "Attack")
	set_process(true)

func _process(delta):
	
	if is_colliding():
		print ("colliding")
		print (get_collider())
		if get_collider().get_meta("Type") == "Enemy":
			get_collider().free()