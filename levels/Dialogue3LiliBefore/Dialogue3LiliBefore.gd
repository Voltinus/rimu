extends "res://templates/Dialogue/Dialogue.gd"

func _ready():
	dialogue_lines = [
		["Rimu", "DIAL_RIMU4"],
		["Lili", "DIAL_LILI1"],
		["Rimu", "DIAL_RIMU5"],
		["Lili", "DIAL_LILI2"],
		["Rimu", "DIAL_RIMU6"],
		["Lili2", "DIAL_LILI3"]
	]
	
	next_stage = "Level2Earth"
	
	_update()
