extends "res://templates/Dialogue/Dialogue.gd"

func _ready():
	dialogue_lines = [
		["Rimu", "DIAL_RIMU20"],
		["Aria2", "DIAL_ARIA4"],
		["Rimu", "DIAL_RIMU21"],
		["Aria2", "DIAL_ARIA5"]
	]
	
	next_stage = "Dialogue9DarekhBefore"
	
	_update()
