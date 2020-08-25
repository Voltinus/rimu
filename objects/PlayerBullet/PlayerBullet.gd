extends Area2D
class_name PlayerBullet

var _SPEED = 300
var velocity = Vector2()


func init(vel, pos, type = "default"):
	velocity = vel.normalized()
	position = pos
	($AnimatedSprite as AnimatedSprite).play(type)


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
