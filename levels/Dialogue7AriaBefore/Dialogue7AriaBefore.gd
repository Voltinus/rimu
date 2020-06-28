extends "res://templates/Dialogue/Dialogue.gd"

func _ready():
	dialogue_lines = [
		["Rimu", "DIAL_RIMU16"],
		["Aria", "DIAL_ARIA1"],
		["Rimu", "DIAL_RIMU17"],
		["Aria", "DIAL_ARIA2"],
		["Rimu", "DIAL_RIMU18"],
		["Rimu", "DIAL_RIMU19"],
		["Aria", "DIAL_ARIA3"]
	]
	
	next_stage = "Level4Air"
	
	_update()
