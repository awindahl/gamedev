extends Node2D

onready var myArea = get_node("Area2D")

func _ready():
	self.set_meta("Type", "NPC")
	pass

func _on_Area2D_body_enter( body ):
	if (body.get_meta("Type") == "Player" && Input.is_action_pressed("ui_action")):
		print("IM GAY")