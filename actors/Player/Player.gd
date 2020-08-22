extends KinematicBody2D
class_name Player


var velocity: Vector2
export var speed: int = 120
export var max_hp: int = 20
var hp: int = max_hp
var shooting: bool = true

var Bullet: PackedScene = preload("res://objects/PlayerBullet/PlayerBullet.tscn")

signal hitted(hp_left)
signal died


func _physics_process(_delta) -> void:
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	velocity = velocity.normalized()
	
	if Input.is_action_pressed("slow_down"):
		velocity *= 0.5
	
	var _collisions = move_and_slide(velocity * speed)


func _on_ShootTimer_timeout() -> void:
	if !shooting: return
	var node: PlayerBullet = Bullet.instance()
	node.init(Vector2(0, -1), position + Vector2(0, -20))
	get_parent().add_child(node)


func hit(damage: int) -> void:
	($AnimationPlayer as AnimationPlayer).play("damage")
	hp = int(max(0, hp - damage))
	emit_signal("hitted", float(hp)/max_hp)
	if hp == 0:
		emit_signal("died")
		print("dead")
		self.queue_free()


func _on_Enemy_died() -> void:
	($ShootTimer as Timer).stop()
