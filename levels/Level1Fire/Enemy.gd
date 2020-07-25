extends "res://actors/Enemy/Enemy.gd"


var LavaWalls = preload("res://objects/LavaWalls/LavaWalls.tscn")
var FireLine  = preload("res://objects/FireLine/FireLine.tscn")


func _ready():
	states = [
		{ "shooting": false },
		{ "target": Vector2(0.2, 0.1) },
		{ "shooting": true },
		{ "target": Vector2(0.5, 0.1) },
		{ "callback": "fn" },
		{ "wait": 3 }
	]

func fn():
	shooting = false
	for _i in range(3):
		for j in range(5):
			if not alive:
				return
			burst(24, j/10.0)
			yield(get_tree().create_timer(0.15), 'timeout')
		yield(get_tree().create_timer(0.5), 'timeout')
	callback_ended = true


func _on_ShootTimer_timeout():
	if not alive or !shooting or get_node('../Player') == null:
		return
	
	if float(hp)/MAX_HP < 0.5:
		for i in range(3):
			var node = Bullet.instance()
			var vel = (get_node('../Player').position - position + Vector2((i-1)*10, 0)).normalized()
			node.init(vel, position, 'flame')
			get_parent().add_child(node)
	else:
		var node = Bullet.instance()
		var vel = (get_node('../Player').position - position).normalized()
		node.init(vel, position, _element)
		get_parent().add_child(node)
