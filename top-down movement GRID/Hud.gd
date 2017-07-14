extends Control

var myMP = main.myMp;
var currentMP = myMP;
var subtractMP = 0;
var usingMP = false

func _ready():
	
	get_node("Panel/MPLabel").set_text(var2str(currentMP) + "/" + var2str(myMP))
	set_fixed_process(true)
	
func _fixed_process(delta):
	
	if usingMP:
		currentMP = currentMP - subtractMP;
		if currentMP < 0:
			currentMP = 0
			
		get_node("Panel/MPActual").set_size(Vector2(get_node("Panel/MPActual").get_size().x-(get_node("Panel/MPOutline").get_size().x*(float(subtractMP)/float(myMP))),get_node("Panel/MPActual").get_size().y))
		get_node("Panel/MPLabel").set_text(var2str(currentMP) + "/" + var2str(myMP))
		usingMP = false;

func _on_Button_pressed():
	if currentMP == 0:
		pass
	subtractMP = 2;
	usingMP = true;
