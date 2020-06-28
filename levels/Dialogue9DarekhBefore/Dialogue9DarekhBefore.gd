extends "res://templates/Dialogue/Dialogue.gd"

func _ready():
	dialogue_lines = [
		["Rimu", "DIAL_RIMU16"]
	]
	
	next_stage = "Level5Dark"
	
	_update()
