extends "res://templates/Dialogue/Dialogue.gd"

func _ready():
	dialogue_lines = [
		["Feren2", "DIAL_FEREN3"],
		["Rimu",  "DIAL_RIMU3"],
		["Feren2", "DIAL_FEREN4"]
	]
	
	next_stage = "Dialogue3LiliBefore"
	
	_update()
