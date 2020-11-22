extends 'res://actors/Enemy/Enemy.gd'


var Rock = preload('res://levels/Level2Earth/Objects/Rock/Rock.tscn')


func _ready():
	states = [
		{ 'shooting': false },
		{ 'callback': 'lower_corners_shooting' },
		
		{ 'shooting': true },
		{ 'shooting_mode': 'triple' },
		{ 'callback': 'falling_rocks' },
		
		{ 'shooting': false },
		{ 'callback': 'shoot_off_walls' },
	]
	
	states2 = [
		{ 'shooting': false },
		{ 'callback': 'rock_maze' }
	]


func lower_corners_shooting():
	for _i in range(15):
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

			burst(24)

			yield(get_tree().create_timer(0.2), 'timeout')
	callback_ended = true


func falling_rocks():
	for _i in range(10):
		for j in range(2):
			var node = Rock.instance()
			node.position = Vector2(Global.game_width() * (0.2 + 0.6*j), 0)
			get_parent().add_child(node)
		yield(get_tree().create_timer(0.5), 'timeout')
	yield(get_tree().create_timer(3), 'timeout')
	callback_ended = true

func shoot_off_walls():
	for _i in range(25):
		for j in range(2):
			var player_pos = (get_node('../Player') as Player).position
			var node: EnemyBullet = EnemyBullet.instance()
			
			var vel
			
			if j == 0:
				vel = player_pos * Vector2(-1, 1) - position
			else:
				var to_edge = Global.game_width() - player_pos.x
				vel = player_pos + Vector2(2 * to_edge, 0) - position
			
			vel += Vector2(randf(), randf())
			
			node.init(vel.normalized(), position, _element, {'bouncing': true})
			$'../Bullets'.add_child(node)
		yield(get_tree().create_timer(0.2), 'timeout')
	yield(get_tree().create_timer(2), 'timeout')
	callback_ended = true


func rock_maze():
	for _i in range(5):
		var hole = randi() % 24
		
		for j in range(24):
			if j == hole:
				continue
			var node = Rock.instance()
			node.position = Vector2(j*10 + 10, 0)
			get_parent().add_child(node)
		yield(get_tree().create_timer(2), 'timeout')
	callback_ended = true
