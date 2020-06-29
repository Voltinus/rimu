extends "res://templates/Dialogue/Dialogue.gd"

func _ready():
	dialogue_lines = [
		["Rimu", "DIAL_RIMU11"],
		["?Vada", "DIAL_VADA1"],
		["Rimu", "DIAL_RIMU12"],
		["?Vada", "DIAL_VADA2"],
		["Rimu", "DIAL_RIMU13"],
	]
	
	next_stage = "Level3Water"
	
	_update()
