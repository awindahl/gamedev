extends Control

var s = seed(randi());

func _ready():
	randomize(s);
	pass;

func _on_Button_1_pressed():
	# Roll four d20s 
	for i in range(4):
		var dice = rand_range(1.0,20.0);
		if dice >= 19.5:
			dice = 10;
		else:
			dice = dice/2;
			dice = floor(dice);
		
		if dice == 0:
			dice += 1;
		var dice_str = str(dice);
		
		# assign each die to global variable
		if ( i == 0 ):
			main.strength = dice;
		if ( i == 1 ):
			main.agility = dice;
		if ( i == 2 ):
			main.charisma = dice;
		if ( i == 3 ):
			main.intellect = dice;
		
		#Show the die rolls
		var output = get_node("StatRoller/RichTextLabel " + var2str(i+2));
		output.set_bbcode(dice_str);
