extends "res://templates/Dialogue/Dialogue.gd"

func _ready():
	dialogue_lines = [
		["Vada", "DIAL_VADA3"],
		["Rimu", "DIAL_RIMU14"],
		["Vada2", "DIAL_VADA4"],
		["Rimu", "DIAL_RIMU15"]
	]
	
	next_stage = "Dialogue7AriaBefore"
	
	_update()
