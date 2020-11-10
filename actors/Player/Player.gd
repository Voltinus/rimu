extends KinematicBody2D
class_name Player


var velocity: Vector2
export var speed := 120
export var MAX_HP := 20
var hp := MAX_HP
var shooting := true
var immortal := false

var hp_runes := 0 
var attack_runes := 0

var Bullet := preload('res://objects/PlayerBullet/PlayerBullet.tscn')

signal stats_changed(hp_left, hp_runes, attack_runes)
signal died


func _ready() -> void:
	emit_signal('stats_changed', float(hp)/MAX_HP, hp_runes, attack_runes)


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
	
	if Input.is_action_just_pressed('use_book'):
		powerup('book', Global.player_book)
		Global.player_book = ''
		get_tree().get_nodes_in_group('book_slot')[0].play('none')


func _on_ShootTimer_timeout() -> void:
	if !shooting: return
	var node: PlayerBullet = Bullet.instance()
	node.init(Vector2(0, -1), position + Vector2(0, -20))
	$'../Bullets'.add_child(node)


func hit(damage: int) -> void:
	if immortal: return
	($AnimationPlayer as AnimationPlayer).play('damage')
	hp = int(max(0, hp - damage))
	emit_signal('stats_changed', float(hp)/MAX_HP, hp_runes, attack_runes)
	if hp == 0:
		emit_signal('died')
		print('dead')
		($ShootTimer as Timer).stop()


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
								var node : PlayerBullet = Bullet.instance()
								var vel: Vector2 = Vector2(sin((i/24.0)*TAU + d), cos((i/24.0)*TAU + d))
								(node as PlayerBullet).init(vel, position, "round")
								get_parent().add_child(node)
							yield(get_tree().create_timer(0.15), 'timeout')
						yield(get_tree().create_timer(0.5), 'timeout')
				'water':
					hp = int(min(hp + 7, MAX_HP))
					emit_signal('stats_changed', float(hp)/MAX_HP, hp_runes, attack_runes)
				'earth':
					immortal = true
					yield(get_tree().create_timer(3), 'timeout')
					immortal = false
				'air':
					#$Shield.visible = 
					pass
				'dark':
					($'../Enemy' as Enemy).set_darkness()
				'white':
					Global.set_bullets_avoid_player(true)
					yield(get_tree().create_timer(5), 'timeout')
					Global.set_bullets_avoid_player(false)
				'black':
					Global.stop_time(3)
				'gray':
					get_tree().call_group('enemy_bullets', 'change_to_player_bullet')
