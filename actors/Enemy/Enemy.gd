extends KinematicBody2D


var _element = null
var Bullet = preload("res://objects/EnemyBullet/EnemyBullet.tscn")
const MAX_HP = 100
var hp = MAX_HP
var alive = true


signal hitted(hp_left)
signal died


func init(element):
	_element = element
	$AnimatedSprite.animation = element
	_next_state()


func burst(n):
	n = float(n)
	var d = randf()
	for i in range(n):
		var node = Bullet.instance()
		var vel = Vector2(sin((i/n)*TAU + d), cos((i/n)*TAU + d))
		node.init(vel, position, _element)
		get_parent().add_child(node)


func hit(damage):
	if !alive:
		return
	
	hp = max(0, hp - damage)
	emit_signal("hitted", float(hp)/MAX_HP)
	$AnimationPlayer.play("damage")
	if hp == 0:
		emit_signal("died")
		alive = false
		state = "DIED"
		target = Vector2(60, 20)
		

const SPEED = 30
var state = null
var next_state_name = "IDLING"
var velocity : Vector2
var target   = Vector2(60, 20)

func _next_state():
	if not alive:
		return
	
	state = next_state_name
	next_state_name = null
		
	match state:
		"IDLING":
			yield(get_tree().create_timer(0.5), "timeout")
			next_state_name = "MOVING_LEFT"
		"MOVING_LEFT":
			target = Vector2(25, 20)
			next_state_name = "MOVING_RIGHT"
		"MOVING_RIGHT":
			target = Vector2(95, 20)
			next_state_name = "MOVING_CENTER"
		"MOVING_CENTER":
			target = Vector2(60, 20)
			next_state_name = "BURSTING"
		"BURSTING":
			shooting = false
			for _i in range(3):
				for _j in range(5):
					if not alive or state != "BURSTING":
						return
					burst(24)
					yield(get_tree().create_timer(0.15), "timeout")
				yield(get_tree().create_timer(0.5), "timeout")
			
			shooting = true
			next_state_name = "MOVING_LEFT"

func _physics_process(_delta):
	if position.distance_to(target) > 1:
		velocity = (target - position).normalized() * SPEED
		velocity = move_and_slide(velocity)
	elif next_state_name != null:
		_next_state()


var shooting = true

func _on_ShootTimer_timeout():
	if not alive or !shooting or get_node("../Player") == null:
		return
	
	if _element == "fire" and float(hp)/MAX_HP < 0.5:
		for i in range(3):
			var node = Bullet.instance()
			var vel = (get_node("../Player").position - position + Vector2((i-1)*10, 0)).normalized()
			node.init(vel, position, "flame")
			get_parent().add_child(node)
	else:
		var node = Bullet.instance()
		var vel = (get_node("../Player").position - position).normalized()
		node.init(vel, position, _element)
		get_parent().add_child(node)
