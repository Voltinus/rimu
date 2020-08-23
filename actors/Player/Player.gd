extends KinematicBody2D
class_name Player


var velocity: Vector2
export var speed := 120
export var MAX_HP := 20
var hp := MAX_HP
var shooting := true
var immortal := false

var Bullet := preload('res://objects/PlayerBullet/PlayerBullet.tscn')

signal hp_changed(hp_left)
signal died


func _physics_process(_delta) -> void:
	velocity = Vector2(0, 0)
	if Input.is_action_pressed('move_left'):
		velocity.x -= 1
	if Input.is_action_pressed('move_right'):
		velocity.x += 1
	if Input.is_action_pressed('move_up'):
		velocity.y -= 1
	if Input.is_action_pressed('move_down'):
		velocity.y += 1
	
	velocity = velocity.normalized()
	
	if Input.is_action_pressed('slow_down'):
		velocity *= 0.5
	
	var _collisions = move_and_slide(velocity * speed)


func _on_ShootTimer_timeout() -> void:
	if !shooting: return
	var node: PlayerBullet = Bullet.instance()
	node.init(Vector2(0, -1), position + Vector2(0, -20))
	get_parent().add_child(node)


func hit(damage: int) -> void:
	if immortal: return
	($AnimationPlayer as AnimationPlayer).play('damage')
	hp = int(max(0, hp - damage))
	emit_signal('hp_changed', float(hp)/MAX_HP)
	if hp == 0:
		emit_signal('died')
		print('dead')
		self.queue_free()


func _on_Enemy_died() -> void:
	($ShootTimer as Timer).stop()


func powerup(type: String, elem: String) -> void:
	match type:
		'book':
			match elem:
				'fire':
					for _i in range(3):
						for _j in range(5):
							for i in range(24):
								var d = 0
								var node: = Bullet.instance()
								var vel: Vector2 = Vector2(sin((i/24.0)*TAU + d), cos((i/24.0)*TAU + d))
								node.init(vel, position, "round")
								get_parent().add_child(node)
							yield(get_tree().create_timer(0.15), 'timeout')
						yield(get_tree().create_timer(0.5), 'timeout')
				'water':
					hp = min(hp + 7, MAX_HP)
					emit_signal('hp_changed', float(hp)/MAX_HP)
				'earth':
					immortal = true
					yield(get_tree().create_timer(3), 'timeout')
					immortal = false
				'air':
					($ShootTimer as Timer).wait_time /= 2
					yield(get_tree().create_timer(5), 'timeout')
					($ShootTimer as Timer).wait_time *= 2
				'dark':
					$'../Enemy'.set_darkness()
