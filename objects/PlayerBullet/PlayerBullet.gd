extends Area2D


const _SPEED = 300
var velocity = Vector2()


func init(vel, pos):
	velocity = vel.normalized()
	position = pos


func _physics_process(delta):
	position.x += velocity.x * _SPEED * delta
	position.y += velocity.y * _SPEED * delta
	if position.x < -5 or position.x > 245 or position.y < -5 or position.y > 305:
		self.queue_free()


func _on_PlayerBullet_body_entered(body):
	if body.has_method("hit"):
		body.hit(1)
		self.queue_free()
