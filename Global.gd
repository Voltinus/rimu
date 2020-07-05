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

func window_width():
	return ProjectSettings.get_setting("display/window/size/width")

func window_height():
	return ProjectSettings.get_setting("display/window/size/height")

func game_width():
	return window_width() * 0.6

func game_height():
	return window_height()
