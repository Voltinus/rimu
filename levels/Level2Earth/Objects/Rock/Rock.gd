extends Area2D


const _SPEED = 100
var velocity := Vector2(0, 1)


func _physics_process(delta: float) -> void:
	if Global.time_stopped: return
	
	position += velocity * _SPEED * delta
	
	if position.x < -20 or position.x > Global.game_width() + 20 or position.y < -40 or position.y > Global.game_height() + 40:
		self.queue_free()


func _on_Rock_body_entered(body):
	if body.has_method("hit"):
		body.hit(5)
		self.queue_free()
