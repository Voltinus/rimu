extends Node

var highscores = {
	'fire_highscore':  0,
	'earth_highscore': 0,
	'water_highscore': 0,
	'air_highscore':   0,
	'dark_highscore':  0
}

func _ready():
	randomize()
	var save_game := File.new()
	if not save_game.file_exists("user://highscores.save"):
		save_highscores()
	else:
		load_highscores()
	save_game.close()

func load_highscores() -> void:
	var save_game := File.new()
	var _ret = save_game.open("user://highscores.save", File.READ)
	highscores = parse_json(save_game.get_line())

func save_highscores() -> void:
	var dir = Directory.new()
	dir.remove("user://highscores.save")
	
	var save_game := File.new()
	var _ret = save_game.open("user://highscores.save", File.WRITE)
	save_game.store_line(to_json(highscores))

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
	get_tree().call_group('should_stop_with_time', 'time_stopped')
	yield(get_tree().create_timer(t), 'timeout')
	time_stopped = false

var player_book: String = 'dark'

var bullets_avoid_player = false

func do_bullets_avoid_player():
	return bullets_avoid_player

func set_bullets_avoid_player(val: bool):
	bullets_avoid_player = val
