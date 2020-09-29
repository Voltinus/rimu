extends Node2D


var _element: String


var Scroll = preload("res://objects/Scroll/Scroll.tscn")
var Book   = preload("res://objects/Book/Book.tscn")


func init(elem: String):
	_element = elem
	($ScrollingBackground as ScrollingBackground).init(elem)
	($GUI as GUI).init(elem)
	($Game/Enemy as Enemy).init(elem)
	
	if Global.player_book != '':
		get_tree().get_nodes_in_group('book_slot')[0].play(Global.player_book)


func _scroll_fall(node: Scroll):
	for _i in range(30):
		node.position.y += 1
		yield(get_tree().create_timer(0.05), "timeout")
	_scroll_bounce(node)

func _scroll_bounce(node: Scroll):
	while true:
		for _i in range(3):
			node.position.y -= 1
			yield(get_tree().create_timer(0.2), "timeout")
		for _i in range(3):
			node.position.y += 1
			yield(get_tree().create_timer(0.2), "timeout")


func _on_Enemy_hitted(hp_left: float):
	($GUI as GUI).update_boss_stats(hp_left)


func _on_Enemy_died():
	($ScrollingBackground as ScrollingBackground).stop_scrolling()
	yield(get_tree().create_timer(2), "timeout")
	var node: Scroll = Scroll.instance()
	node.init(_element)
	node.position = ($Game/Enemy as Enemy).position
	$Game.add_child(node)
	_scroll_fall(node)


func _on_BookSpawner_timeout():
	var node: Book = Book.instance()
	node.position = Vector2(randf()*Global.game_width(), -5)
	$Game.add_child(node)


func _on_Player_stats_changed(hp_left: float, hp_runes: int, attack_runes: int):
	($GUI as GUI).update_player_stats(hp_left, hp_runes, attack_runes)
	
