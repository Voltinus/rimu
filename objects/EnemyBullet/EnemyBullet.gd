extends Area2D
class_name EnemyBullet


const _SPEED = 100
var velocity: Vector2
var _element: String
var factor: int
var bouncing: bool = false

var PlayerBullet := preload('res://objects/PlayerBullet/PlayerBullet.tscn')


func init(vel: Vector2, pos: Vector2, elem: String, params = {}) -> void:
	if Global.darkness:
		self.queue_free()
		return
	
	factor = int(vel.length())
	if factor == 0: factor = 1
	velocity = vel.normalized()
	position = pos
	_element = elem
	if params.has('bouncing'):
		bouncing = params.bouncing
	($AnimatedSprite as AnimatedSprite).play(elem)


func _physics_process(delta: float) -> void:
	if Global.time_stopped: return
	
	if Global.do_bullets_avoid_player():
		var player_position: Vector2 = get_tree().get_nodes_in_group('player')[0].position
		var distance = player_position.distance_to(position)
		velocity += (position - player_position).normalized() / distance
		velocity = velocity.normalized()
	
	position += velocity * _SPEED * delta * factor
	
	if bouncing:
		# approx bullet width
		var w = 5
		
		if position.x < 0:
			position.x *= -1
			velocity.x *= -1
		elif position.x + w > Global.game_width():
			var beyond_by = (position.x + w) - Global.game_width()
			position.x = Global.game_width() - beyond_by
			velocity.x *= -1
	
	if position.x < -5 or position.x > Global.game_width() + 5 or position.y < -5 or position.y > Global.game_height() + 5:
		self.queue_free()


func _on_EnemyBullet_body_entered(body) -> void:
	if body.has_method("hit"):
		body.hit(1)
		self.queue_free()


func time_stopped():
	($AnimatedSprite as AnimatedSprite).stop()
	while Global.time_stopped: yield(get_tree().create_timer(0.01), 'timeout')
	($AnimatedSprite as AnimatedSprite).play(_element)


func change_to_player_bullet():
	var node: PlayerBullet = PlayerBullet.instance()
	node.init(Vector2(0, -1), position)
	get_parent().add_child(node)
	self.queue_free()
