extends 'res://actors/Enemy/Enemy.gd'


var LavaWalls = preload('res://levels/Level1Fire/Objects/LavaWalls/LavaWalls.tscn')
var FireLine  = preload('res://levels/Level1Fire/Objects/FireLine/FireLine.tscn')


func _ready():
	states = [
		{ 'shooting_mode': 'triple' },
		{ 'target': Vector2(0.8, 0.2) },
		{ 'shooting': true },
		{ 'speed': 1 },
		{ 'target': Vector2(0.2, 0.2) },
		{ 'shooting': false },
		{ 'speed': 2 },
		{ 'target': Vector2(0.5, 0.1) },
		{ 'wait': 1 },
		{ 'callback': 'byle_jak' }
	]
	
	states2 = [
		{ 'speed': 1 },
		{ 'target': Vector2(0.5, 0.1) },
		{ 'shooting': false },
		{ 'callback': 'curtain' },
		{ 'shooting': true },
		{ 'callback': 'fire_lines' },
		{ 'shooting': false },
		{ 'callback': 'triple_burst' },
	]
	
	states3 = [
		{ 'speed': 1 },
		{ 'target': Vector2(0.5, 0.1) },
		{ 'shooting': false },
		{ 'callback': 'spawn_lava_walls' },
		{ 'label': 'start' },
		{ 'callback': 'maze' },
		{ 'callback': 'fire_lines' },
		{ 'shooting': true },
		{ 'callback': 'corner_shooting' },
		{ 'shooting': false },
		{ 'next': 'start' },
	]
	
	states4 = [
		
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

func maze():
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
			node.init(vel, pos, 'flame')
			
			var scale = randf() + 1.0
			node.scale = Vector2(scale, scale)
			
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
				node.init(vel, pos, 'flame')
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

func spawn_lava_walls():
	var lava_walls_instance: Area2D = LavaWalls.instance()
	($'/root/Level1Fire/Game' as Node2D).add_child(lava_walls_instance)
	callback_ended = true

func corner_shooting():
	for i in range(25):
		for j in range(2):
			var node: EnemyBullet = EnemyBullet.instance()
			
			var shooting_from: Vector2
			if j == 0:
				shooting_from = Vector2(5, Global.game_height() - 5)
			else:
				shooting_from = Vector2(Global.game_width() - 5, Global.game_height() - 5)
			
			var vel: Vector2 = ((get_node('../Player') as Player).position - shooting_from).normalized()
			var pos: Vector2 = Vector2(5 + (Global.game_width() - 10) * j, Global.game_height() - 5)
			
			node.init(vel, pos, _element)
			$'../Bullets'.add_child(node)
			
			yield(get_tree().create_timer(0.2), 'timeout')

func _on_ShootTimer_timeout():
	if not alive or !shooting or darkness or (get_node('../Player') as Player) == null:
		return
	
	for i in range(3):
		var node: EnemyBullet = EnemyBullet.instance()
		var vel: Vector2 = ((get_node('../Player') as Player).position - position + Vector2((i-1)*20, 0)).normalized()
		if float(hp)/max_hp < 0.5:
			node.init(vel, position, 'flame')
		else:
			node.init(vel, position, _element)
		$'../Bullets'.add_child(node)
