extends KinematicBody2D


var velocity = Vector2()
export var speed = 120
export var max_hp = 20
var hp = max_hp

var Bullet = preload("res://objects/PlayerBullet/PlayerBullet.tscn")


signal hitted(hp_left)
signal died


func _physics_process(_delta):
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	var _collisions = move_and_slide(velocity * speed)


func _on_ShootTimer_timeout():
	var node = Bullet.instance()
	node.init(Vector2(0, -1), position)
	get_parent().add_child(node)


func hit(damage):
	$AnimationPlayer.play("damage")
	hp = max(0, hp - damage)
	emit_signal("hitted", float(hp)/max_hp)
	if hp == 0:
		emit_signal("died")
		print("dead")
		self.queue_free()


func _on_Enemy_died():
	$ShootTimer.stop()
