extends "res://templates/Dialogue/Dialogue.gd"

func _ready():
	dialogue_lines = [
		["Darek'h", "DIAL_DAREKH3"],
		["Rimu", "DIAL_RIMU24"],
		["Darek'h", "DIAL_DAREKH4"]
	]
	
	next_stage = "EndOfVersion"
	
	_update()
