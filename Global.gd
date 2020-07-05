extends Node

func _ready():
	randomize()

func _process(_delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen

func goto_scene(scn: String):
	var scene_path = "res://levels/%s/%s.tscn" % [scn, scn]
	if get_tree().change_scene(scene_path) != OK:
		print("Error: Unable to change scene to " + scn)

func quit():
	get_tree().quit()

func game_width():
	return ProjectSettings.get_setting("display/window/size/width") * 0.6

func game_height():
	return ProjectSettings.get_setting("display/window/size/height")

# function to convert point between (0, 0) and (1, 1)
# to value between 0 and game area size
func unit_to_game(point: Vector2):
	return Vector2(point.x * game_width(), point.y * game_height());
