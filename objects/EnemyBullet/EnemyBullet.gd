extends Area2D
class_name EnemyBullet


const _SPEED = 100
var velocity: Vector2
var _element: String
var factor: int

var PlayerBullet := preload('res://objects/PlayerBullet/PlayerBullet.tscn')


func init(vel: Vector2, pos: Vector2, elem: String) -> void:
	factor = int(vel.length())
	if factor == 0: factor = 1
	velocity = vel.normalized()
	position = pos
	_element = elem
	($AnimatedSprite as AnimatedSprite).play(elem)


func _physics_process(delta: float) -> void:
	if Global.time_stopped: return
	
	if Global.bullets_avoid_player:
		var player_position: Vector2 = get_tree().get_nodes_in_group('player')[0].position
		var distance = player_position.distance_to(position)
		var direct_vector = (player_position - position).normalized()
		var angle_to_player = velocity.angle_to(direct_vector)
		velocity += Vector2(cos(angle_to_player), -sin(angle_to_player)) * (5/distance)
		velocity = velocity.normalized()
	
	position.x += velocity.x * _SPEED * delta * factor
	position.y += velocity.y * _SPEED * delta * factor
	
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
