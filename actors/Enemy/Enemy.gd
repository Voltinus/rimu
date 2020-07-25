extends KinematicBody2D


const MAX_HP = 200
var hp = MAX_HP
var alive = true
var _element = null

var Bullet = preload('res://objects/EnemyBullet/EnemyBullet.tscn')

signal hitted(hp_left)
signal died

var shooting = true

var current_state: int = 0
var states = [
	{ 'target': Vector2(0.5, 0.1) }
]

# These states are copied by reference to "states"
# after reaching tresholds 75%, 50% i 25% np
var states2 = null
var states3 = null
var states4 = null


func init(element):
	_element = element
	$AnimatedSprite.animation = element
	do_state()


func burst(n, d = -1):
	n = float(n)
	
	if d == -1:
		d = randf()
	
	for i in range(n):
		var node = Bullet.instance()
		var vel = Vector2(sin((i/n)*TAU + d), cos((i/n)*TAU + d))
		node.init(vel, position, _element)
		get_parent().add_child(node)


var treshold_reached = 0

func hit(damage):
	if !alive:
		return
	
	hp = max(0, hp - damage)
	emit_signal('hitted', float(hp)/MAX_HP)
	$AnimationPlayer.play('damage')
	if hp == 0:
		emit_signal('died')
		alive = false
	
	if float(hp)/MAX_HP <= 0.75 and states2 != null:
		treshold_reached = 2
	
	if float(hp)/MAX_HP <= 0.5 and states3 != null:
		treshold_reached = 3
	
	if float(hp)/MAX_HP <= 0.25 and states4 != null:
		treshold_reached = 4
	
	

const SPEED = 30
var velocity : Vector2
var target   = Vector2(60, 20)

var target_reached = false
var delay_finished = false
var callback_ended = false

func do_state():
	while alive:
		if !states[current_state].has('target'):
			target_reached = true
		
		if !states[current_state].has('wait'):
			delay_finished = true
		
		if !states[current_state].has('callback'):
			callback_ended = true
		
		if states[current_state].has("shooting"):
			shooting = states[current_state].shooting
		
		if states[current_state].has("callback"):
			call(states[current_state].callback)
		
		if states[current_state].has("wait"):
			yield(get_tree().create_timer(states[current_state].wait), "timeout")
			delay_finished = true
		
		while !target_reached: yield(get_tree().create_timer(0.01), 'timeout')
		while !delay_finished: yield(get_tree().create_timer(0.01), 'timeout')
		while !callback_ended: yield(get_tree().create_timer(0.01), 'timeout')
		
		if !treshold_reached:
			if states[current_state].has("next"):
				for i in range(0, states.size()):
					if states[i].has("label") and states[i].label == states[current_state].next:
						current_state = i
			elif current_state+1 == states.size():
				current_state = 0
			else:
				current_state += 1
		else:
			match treshold_reached:
				2:
					states = states2
					states2 = null
				3:
					states = states3
					states3 = null
				4:
					states = states4
					states4 = null
			current_state = 0
			treshold_reached = 0
		
		target_reached = false
		delay_finished = false
		callback_ended = false

func _physics_process(_delta):
	if states[current_state].has("target"):
		var current_target = states[current_state].target
		current_target *= Vector2(Global.game_width(), Global.game_height())
		if position.distance_to(current_target) > 1:
			velocity = (current_target - position).normalized() * SPEED
			velocity = move_and_slide(velocity)
		else:
			target_reached = true



func _on_ShootTimer_timeout():
	if not alive or !shooting or get_node('../Player') == null:
		return
	
	var node = Bullet.instance()
	var vel = (get_node('../Player').position - position).normalized()
	node.init(vel, position, _element)
	get_parent().add_child(node)
