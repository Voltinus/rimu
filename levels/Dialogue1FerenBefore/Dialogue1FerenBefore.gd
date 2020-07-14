extends "res://templates/Dialogue/Dialogue.gd"

func _ready():
	dialogue_lines = [
		["Rimu",  "DIAL_RIMU1"],
		["Feren", "DIAL_FEREN1"],
		["Rimu",  "DIAL_RIMU2"],
		["Feren2", "DIAL_FEREN2"]
	]
	
	next_stage = "Level1Fire"
	
	_update()
