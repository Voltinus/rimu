extends Node

func _ready():
	randomize()

func goto_scene(scn):
	var scene_path = "res://levels/%s/%s.tscn" % [scn, scn]
	if get_tree().change_scene(scene_path) != OK:
		print("Error: Unable to change scene to " + scn)

func quit():
	get_tree().quit()
