extends Node2D
class_name ScrollingBackground

signal scrolling_stopped


var background: Resource

func init(element: String):
	background = load("res://templates/ScrollingBackground/arena_%s.png" % element)
	
	($Sprite as Sprite).texture = (background as Texture)
	($Sprite as Sprite).texture.set_flags(3) # defaults, but without filter
	($Sprite2 as Sprite).texture = (background as Texture)
	($Sprite2 as Sprite).texture.set_flags(3)
	
	_start_scrolling()


var _step = 15
var scrolling = false

func _start_scrolling():
	scrolling = true

func _process(delta):
	if Global.time_stopped: return
	position.y += delta * _step
	if position.y > Global.game_height():
		position.y -= Global.game_height()

func stop_scrolling():
	var steps = _step
	for _i in range(steps):
		_step -= 1
		yield(get_tree().create_timer(0.1), "timeout")
	emit_signal("scrolling_stopped")
