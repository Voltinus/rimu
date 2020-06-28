extends "res://templates/Dialogue/Dialogue.gd"

func _ready():
	dialogue_lines = [
		["Aria", "DIAL_ARIA1"]
	]
	
	next_stage = "Level4Air"
	
	_update()
