extends Area2D
class_name EnemyBullet


const _SPEED = 100
var velocity: Vector2
var _element: String


func init(vel: Vector2, pos: Vector2, elem: String) -> void:
	velocity = vel
	position = pos
	_element = elem
	($AnimatedSprite as AnimatedSprite).play(elem)


func _physics_process(delta: float) -> void:
	if Global.time_stopped: return
	position.x += velocity.x * _SPEED * delta
	position.y += velocity.y * _SPEED * delta
	if position.x < -5 or position.x > Global.game_width() + 5 or position.y < -5 or position.y > Global.game_height() + 5:
		self.queue_free()


func _on_EnemyBullet_body_entered(body: Node) -> void:
	if body.has_method("hit"):
		(body as Player).hit(1)
		self.queue_free()
