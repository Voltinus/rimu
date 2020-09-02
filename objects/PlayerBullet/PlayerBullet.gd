extends Area2D
class_name PlayerBullet

var _SPEED = 300
var velocity = Vector2()
var bullet_type: String


func init(vel, pos, type = "default"):
	velocity = vel.normalized()
	position = pos
	bullet_type = type
	($AnimatedSprite as AnimatedSprite).play(bullet_type)


func _physics_process(delta):
	if Global.time_stopped: return
	position.x += velocity.x * _SPEED * delta
	position.y += velocity.y * _SPEED * delta
	if position.x < -5 or position.x > Global.game_width() + 5 or position.y < -5 or position.y > Global.game_height() + 5:
		self.queue_free()


func _on_PlayerBullet_body_entered(body):
	if body.has_method("hit"):
		body.hit(1)
		self.queue_free()


func time_stopped():
	($AnimatedSprite as AnimatedSprite).stop()
	while Global.time_stopped: yield(get_tree().create_timer(0.01), 'timeout')
	($AnimatedSprite as AnimatedSprite).play(bullet_type)
