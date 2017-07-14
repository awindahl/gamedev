extends Control

var myMP = main.myMp;
var currentMP = myMP;
var changeInMP = 0;
var e = 0;
var usingMP = false
var diff
func _ready():
	
	get_node("Panel/MPLabel").set_text(var2str(currentMP) + "/" + var2str(myMP))
	set_fixed_process(true)
	
func _fixed_process(delta):
	
	
	if usingMP:
		currentMP = currentMP - changeInMP*e;
		diff = floor(get_node("Panel/MPOutline").get_size().x*(float(changeInMP)/float(myMP)))
		if currentMP <= 0:
			currentMP = 0
			diff = get_node("Panel/MPActual").get_size().x
			get_node("Button").set_disabled(true)
		if currentMP > myMP:
			currentMP = myMP
			diff = get_node("Panel/MPOutline").get_size().x-get_node("Panel/MPActual").get_size().x
			
		get_node("Panel/MPActual").set_size(Vector2(get_node("Panel/MPActual").get_size().x-e*diff,get_node("Panel/MPActual").get_size().y))
		get_node("Panel/MPLabel").set_text(var2str(currentMP) + "/" + var2str(myMP))
		usingMP = false;
		changeInMP = 0;

func _on_Button_pressed():
	if currentMP == 0:
		pass
	changeInMP = 2;
	e = 1;
	usingMP = true;
	

func _on_ButtonAdd_pressed():
	if currentMP == myMP:
		pass
	changeInMP = 2;
	e = -1;
	usingMP = true;
	get_node("Button").set_disabled(false)