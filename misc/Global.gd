extends Node

func _ready():
	randomize()

func _process(_delta):
	if Input.is_action_just_pressed('toggle_fullscreen'):
		OS.window_fullscreen = !OS.window_fullscreen
	if Input.is_action_just_pressed('quit'):
		quit()

func goto_scene(scn: String):
	Transition.change_scene(scn)

func quit():
	get_tree().quit()

func window_width() -> int:
	return ProjectSettings.get_setting('display/window/size/width')

func window_height() -> int:
	return ProjectSettings.get_setting('display/window/size/height')

func window_size() -> Vector2:
	return Vector2(window_width(), window_height())

func game_width() -> int:
	return int(window_width() * 0.6)

func game_height() -> int:
	return window_height()

func game_size() -> Vector2:
	return Vector2(game_width(), game_height())


var time_stopped := false

func stop_time(t: int) -> void:
	time_stopped = true
	#get_tree().get_nodes_in_group("stop_time_shader")[0].visible = true
	get_tree().call_group('should_stop_with_time', 'time_stopped')
	yield(get_tree().create_timer(t), 'timeout')
	#get_tree().get_nodes_in_group("stop_time_shader")[0].visible = false
	time_stopped = false
	pass

var player_book: String = ''
