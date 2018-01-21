extends KinematicBody2D

func _ready():
	set_meta("Type", "NPC")

func loadText():
	var file = File.new()
	file.open("res://Assets/Dialogues/" + self.get_name() + ".txt", file.READ)
	var content = file.get_as_text()
	file.close()
	return content
	