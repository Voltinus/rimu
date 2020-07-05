extends Node2D


signal scrolling_stopped


var background

func init(element):
	background = load("res://templates/ScrollingBackground/arena_%s.png" % element)
	
	$Sprite.texture  = background
	$Sprite.texture.set_flags(3) # defaults, but without filter
	$Sprite2.texture = background
	$Sprite2.texture.set_flags(3)
	
	_start_scrolling()


var _step = 15
var scrolling = false

func _start_scrolling():
	scrolling = true

func _process(delta):
	position.y += delta * _step
	if position.y > Global.game_height():
		position.y -= Global.game_height()

func stop_scrolling():
	var steps = _step
	for _i in range(steps):
		_step -= 1
		yield(get_tree().create_timer(0.1), "timeout")
	emit_signal("scrolling_stopped")
