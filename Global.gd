extends Node

func _ready():
	randomize()

func _process(_delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	if Input.is_action_just_pressed("quit"):
		quit()

func goto_scene(scn: String):
	Transition.change_scene(scn)

func quit():
	get_tree().quit()

func window_width() -> int:
	return ProjectSettings.get_setting("display/window/size/width")

func window_height() -> int:
	return ProjectSettings.get_setting("display/window/size/height")

func window_size() -> Vector2:
	return Vector2(window_width(), window_height())

func game_width() -> int:
	return int(window_width() * 0.6)

func game_height() -> int:
	return window_height()

func game_size() -> Vector2:
	return Vector2(game_width(), game_height())
