extends Area2D
class_name PlayerBullet

const _SPEED = 300
var velocity = Vector2()


func init(vel, pos):
	if vel.length() >= 1:
		velocity = vel.normalized()
	else:
		velocity = vel
	position = pos


func _physics_process(delta):
	position.x += velocity.x * _SPEED * delta
	position.y += velocity.y * _SPEED * delta
	if position.x < -5 or position.x > Global.game_width() + 5 or position.y < -5 or position.y > Global.game_height() + 5:
		self.queue_free()


func _on_PlayerBullet_body_entered(body):
	if body.has_method("hit"):
		body.hit(1)
		self.queue_free()
