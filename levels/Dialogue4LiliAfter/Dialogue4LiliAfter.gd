extends "res://templates/Dialogue/Dialogue.gd"

func _ready():
	dialogue_lines = [
		["Lili", "DIAL_LILI4"],
		["Rimu", "DIAL_RIMU7"],
		["Lili", "DIAL_LILI5"],
		["Lili", "DIAL_LILI6"],
		["Rimu", "DIAL_RIMU8"],
		["Lili", "DIAL_LILI7"],
		["Rimu", "DIAL_RIMU9"],
		["Lili", "DIAL_LILI8"],
		["Rimu", "DIAL_RIMU10"]
	]
	
	next_stage = "Dialogue5VadaBefore"
	
	_update()
