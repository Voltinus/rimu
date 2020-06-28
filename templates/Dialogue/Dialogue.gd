extends Control


var textures = {
	"Feren":  preload("res://templates/Dialogue/character_fire.png"),
	"Vada":   preload("res://templates/Dialogue/character_water.png"),
	"Aria":   preload("res://templates/Dialogue/character_air.png"),
	"Lili":   preload("res://templates/Dialogue/character_earth.png"),
	"Darek'h": preload("res://templates/Dialogue/character_dark.png")
}

var name_colors = {
	"Rimu":   Color.mediumturquoise,
	"Feren":  Color.yellow,
	"Vada":   Color.blue,
	"Aria":   Color.gray,
	"Lili":   Color.darkgreen,
	"Darek'h": Color.darkred
}

var dialogue_lines = []

var current_line = 0
var next_stage = ""

func _ready():
	if len(dialogue_lines) > 0:
		_update()

func init(lines, next):
	dialogue_lines = lines
	next_stage = next
	_update()

func _input(event):
	if event.is_action_pressed("dialogue_skip"):
		current_line += 1
		if current_line == len(dialogue_lines):
			Global.goto_scene(next_stage)
		else:
			_update()

func _update():
	var line = dialogue_lines[current_line]
	if line[0] == "Rimu":
		$CharacterRimu.show()
		$CharacterOther.hide()
	else:
		$CharacterRimu.hide()
		$CharacterOther.show()
		$CharacterOther.texture = textures[line[0]]
		
	$Name.text = line[0]
	$Text.text = line[1]
	$Name.modulate = name_colors[line[0]]
