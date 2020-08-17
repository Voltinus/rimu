extends "res://actors/Enemy/Enemy.gd"


var LavaWalls = preload("res://objects/LavaWalls/LavaWalls.tscn")
var FireLine  = preload("res://objects/FireLine/FireLine.tscn")


func _ready():
	states = [
		{ "wait": 1 },
		{ "callback": "byle_jak" },
		{ "target": Vector2(0.8, 0.2) },
		{ "shooting": true },
		{ "speed": 1 },
		{ "target": Vector2(0.2, 0.2) },
		{ "shooting": false },
		{ "speed": 2 },
		{ "target": Vector2(0.5, 0.1) }
	]
	
	states2 = [
		{ "shooting": false },
		{ "speed": 2 },
		{ "target": Vector2(0.5, 0.1) },
		{ "callback": "curtain" }
	]

func byle_jak():
	shooting = false
	for _j in range(50):
		if not alive:
			return
		burst(24)
		yield(get_tree().create_timer(0.15), 'timeout')
	callback_ended = true

func triple_burst():
	shooting = false
	for _i in range(3):
		for j in range(5):
			if not alive:
				return
			burst(24, j/10.0)
			yield(get_tree().create_timer(0.15), 'timeout')
		yield(get_tree().create_timer(0.5), 'timeout')
	callback_ended = true

func curtain():
	
	
	
	callback_ended = true

func spawn_lava_walls():
	var lava_walls_instance = LavaWalls.instance()
	$"/root/Level1Fire/Game".add_child(lava_walls_instance)

func despawn_lava_walls():
	pass

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
