extends Control


var textures: Dictionary = {
	"Feren":   preload("res://templates/Dialogue/character_fire.png"),
	"Vada":    preload("res://templates/Dialogue/character_water.png"),
	"Aria":    preload("res://templates/Dialogue/character_air.png"),
	"Lili":    preload("res://templates/Dialogue/character_earth.png"),
	"Darek'h": preload("res://templates/Dialogue/character_dark.png"),
	"Feren2":   preload("res://templates/Dialogue/character_fire2.png"),
	"Vada2":    preload("res://templates/Dialogue/character_water2.png"),
	"Aria2":    preload("res://templates/Dialogue/character_air2.png"),
	"Lili2":    preload("res://templates/Dialogue/character_earth2.png"),
	"Darek'h2": preload("res://templates/Dialogue/character_dark2.png")
}

var name_colors: Dictionary = {
	"Rimu":   Color.mediumturquoise,
	"Feren":  Color.yellow,
	"Vada":   Color.blue,
	"Aria":   Color.gray,
	"Lili":   Color.darkgreen,
	"Darek'h": Color.darkred
}

var dialogue_lines: Array = []
var current_line: int = 0
var next_stage: String = ""

func _ready():
	if len(dialogue_lines) > 0:
		_update()

func init(lines: Array, next: String):
	dialogue_lines = lines
	next_stage = next
	_update()

func _input(event: InputEvent):
	if event.is_action_pressed("dialogue_skip"):
		current_line += 1
		if current_line == len(dialogue_lines):
			Global.goto_scene(next_stage)
		else:
			_update()

func _update():
	var line: Array = dialogue_lines[current_line]
	var name: String = line[0]
	var text: String = line[1]
	var unknown_name: bool = false
		
	if name[0] == "?":
		unknown_name = true
		name = name.substr(1)
	
	if name == "Rimu":
		($CharacterRimu as TextureRect).show()
		($CharacterOther as TextureRect).hide()
	else:
		($CharacterRimu as TextureRect).hide()
		($CharacterOther as TextureRect).show()
		($CharacterOther as TextureRect).texture = textures[name]
		($CharacterOther as TextureRect).texture.set_flags(3) # defaults, but without filter
	
	($Text as Label).text = text
	
	if name[-1] == "2":
		name = name.substr(0, len(name)-1)
		
	($Name as Label).text = "???" if unknown_name else name
	($Name as Label).modulate = name_colors[name]
