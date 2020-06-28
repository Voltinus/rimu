extends "res://templates/Dialogue/Dialogue.gd"

func _ready():
	dialogue_lines = [
		["Rimu", "DIAL_RIMU20"],
		["Aria", "DIAL_ARIA4"],
		["Rimu", "DIAL_RIMU21"],
		["Aria", "DIAL_ARIA5"]
	]
	
	next_stage = "Dialogue9DarekhBefore"
	
	_update()
