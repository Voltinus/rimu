extends Node2D


var _element


var Scroll = preload("res://objects/Scroll/Scroll.tscn")


func init(elem: String):
	_element = elem
	($ScrollingBackground as ScrollingBackground).init(elem)
	($GUI as GUI).init(elem)
	($Game/Enemy as Enemy).init(elem)


func _scroll_fall(node: Scroll):
	for _i in range(30):
		node.position.y += 1
		yield(get_tree().create_timer(0.05), "timeout")
	_scroll_bounce(node)

func _scroll_bounce(node):
	while true:
		for _i in range(3):
			node.position.y -= 1
			yield(get_tree().create_timer(0.2), "timeout")
		for _i in range(3):
			node.position.y += 1
			yield(get_tree().create_timer(0.2), "timeout")


func _on_Enemy_hitted(hp_left):
	$GUI/BossStats/HPBar.region_rect.size.x = hp_left * Global.game_width()


func _on_Enemy_died():
	$ScrollingBackground.stop_scrolling()
	yield(get_tree().create_timer(2), "timeout")
	var node = Scroll.instance()
	node.init(_element)
	node.position = $Game/Enemy.position
	$Game.add_child(node)
	_scroll_fall(node)


func _on_Player_hitted(hp_left):
	var max_width = $GUI/PlayerStats/HPBarBackground.rect_size.x
	$GUI/PlayerStats/HPBarBackground/HPBar.rect_size.x = hp_left * max_width
