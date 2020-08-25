extends "res://actors/Enemy/Enemy.gd"


var LavaWalls = preload("res://objects/LavaWalls/LavaWalls.tscn")
var FireLine  = preload("res://objects/FireLine/FireLine.tscn")


func _ready():
	states= [
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
		{ "speed": 1 },
		{ "target": Vector2(0.5, 0.1) },
		{ "shooting": false },
		{ "callback": "curtain" },
		{ "shooting": true },
		{ "callback": "fire_lines" },
		{ "shooting": false },
		{ "callback": "triple_burst" },
	]
	
	states3 = [
		{ "speed": 1 },
		{ "target": Vector2(0.5, 0.1) },
		{ "shooting": false },
		{ "callback": "spawn_lava_walls" },
		{ "label": "start" },
		{ "callback": "triple_maze" },
		{ "callback": "fire_lines" },
		{ "next": "start" },
	]

func byle_jak():
	shooting = false
	for _j in range(50):
		if not alive:
			return
		while darkness: yield(get_tree().create_timer(0.01), 'timeout')
		while Global.time_stopped: yield(get_tree().create_timer(0.01), 'timeout')
		burst(24)
		yield(get_tree().create_timer(0.15), 'timeout')
	callback_ended = true

func triple_burst():
	shooting = false
	for _i in range(3):
		for j in range(5):
			if not alive:
				return
			while darkness: yield(get_tree().create_timer(0.01), 'timeout')
			while Global.time_stopped: yield(get_tree().create_timer(0.01), 'timeout')
			burst(24, j/10.0)
			yield(get_tree().create_timer(0.15), 'timeout')
		yield(get_tree().create_timer(0.5), 'timeout')
	callback_ended = true

func triple_maze():
	shooting = false
	for _i in range(10):
		if not alive:
			return
		var rand_int: int = randi()%15 + 12
		while darkness: yield(get_tree().create_timer(0.01), 'timeout')
		while Global.time_stopped: yield(get_tree().create_timer(0.01), 'timeout')
		for k in range(40):
			if rand_int in range(k, k+2): continue
			var node = EnemyBullet.instance()
			var vel = Vector2(0, 1)
			var pos = Vector2(Global.game_width() * (0.05 + 0.0225*k), -3)
			node.init(vel, pos, "flame")
			get_parent().add_child(node)
		yield(get_tree().create_timer(1), 'timeout')
	callback_ended = true

func curtain():
	for i in range(5):
		for j in range(10):
			for k in range(2):
				if not alive:
					return
				while darkness: yield(get_tree().create_timer(0.01), 'timeout')
				while Global.time_stopped: yield(get_tree().create_timer(0.01), 'timeout')
				var node = EnemyBullet.instance()
				var vel = Vector2(0, 2)
				var pos
				if k:
					pos = Vector2(Global.game_width() * (0.05 + i/12.0 + j/100.0 - randf()/100), -3)
				else:
					pos = Vector2(Global.game_width() * (0.95 - i/12.0 - j/100.0 + randf()/100), -3)
				node.init(vel, pos, "flame")
				get_parent().add_child(node)
			yield(get_tree().create_timer(0.05), 'timeout')
		yield(get_tree().create_timer(0.1), 'timeout')
	callback_ended = true

func fire_lines():
	for i in range(3):
		if not alive:
			return
		while darkness: yield(get_tree().create_timer(0.01), 'timeout')
		while Global.time_stopped: yield(get_tree().create_timer(0.01), 'timeout')
		var node = FireLine.instance()
		var node2 = FireLine.instance()
		node.position = Vector2(Global.game_width() * 0.25, Global.game_height() * (0.1 + i*0.3 + randf()/5))
		node2.position = node.position + Vector2(Global.game_width() * 0.5, 0)
		get_parent().add_child(node)
		get_parent().add_child(node2)
		yield(get_tree().create_timer(0.3), 'timeout')
	yield(get_tree().create_timer(5), 'timeout')
	callback_ended = true

func spawn_lava_walls() -> void:
	var lava_walls_instance: Area2D = LavaWalls.instance()
	($"/root/Level1Fire/Game" as Node2D).add_child(lava_walls_instance)
	callback_ended = true

func _on_ShootTimer_timeout():
	if not alive or !shooting or darkness or (get_node('../Player') as Player) == null:
		return
	
	if float(hp)/MAX_HP < 0.5:
		for i in range(3):
			var node: EnemyBullet = EnemyBullet.instance()
			var vel: Vector2 = ((get_node('../Player') as Player).position - position + Vector2((i-1)*10, 0)).normalized()
			node.init(vel, position, 'flame')
			$'../Bullets'.add_child(node)
	else:
		var node: EnemyBullet = EnemyBullet.instance()
		var vel: Vector2 = ((get_node('../Player') as Player).position - position).normalized()
		node.init(vel, position, _element)
		$'../Bullets'.add_child(node)
