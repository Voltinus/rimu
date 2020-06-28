extends "res://templates/Dialogue/Dialogue.gd"

func _ready():
	dialogue_lines = [
		["Rimu", "DIAL_RIMU22"],
		["Darek'h", "DIAL_DAREKH1"],
		["Rimu", "DIAL_RIMU23"],
		["Darek'h", "DIAL_DAREKH2"]
	]
	
	next_stage = "Level5Dark"
	
	_update()
