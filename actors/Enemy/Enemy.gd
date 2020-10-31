extends KinematicBody2D
class_name Enemy


var max_hp: int = 500
var hp: int = max_hp
var alive: bool = true
var _element: String

var EnemyBullet = preload('res://objects/EnemyBullet/EnemyBullet.tscn')

signal hitted(hp_left)
signal died

var shooting: bool = true
var shooting_mode: String = 'single'

var darkness := false

var current_state: int = 0
var states: Array = [
	{ 'target': Vector2(0.5, 0.1) }
]

# These states are copied by reference to 'states'
# after reaching tresholds of 75%, 50% and 25% hp
var states2: Array = []
var states3: Array = []
var states4: Array = []


func init(element: String):
	assert(element in ['fire', 'earth', 'water', 'air', 'dark'])
	
	_element = element
	($AnimatedSprite as AnimatedSprite).animation = element
	
	var hps = {
		'fire': 100,
		'earth': 600,
		'water': 700,
		'air': 800,
		'dark': 1000
	}
	
	max_hp = hps[element]
	hp = max_hp
	
	do_state()


func burst(n: float, d: float = -1):
	if d == -1:
		d = randf()
	
	for i in range(n):
		var node: EnemyBullet = EnemyBullet.instance()
		var vel: Vector2 = Vector2(sin((i/n)*TAU + d), cos((i/n)*TAU + d))
		node.init(vel, position, _element)
		get_parent().add_child(node)


var treshold_reached = 0

func hit(damage: int):
	if !alive:
		return
	
	hp = int(max(0, hp - damage))
	emit_signal('hitted', float(hp)/max_hp)
	($AnimationPlayer as AnimationPlayer).play('damage')
	if hp == 0:
		emit_signal('died')
		Global.highscores[_element + '_highscore'] = 1
		Global.save_highscores()
		alive = false
		if _element == 'fire' and get_parent().has_node('LavaWalls'):
			($'../LavaWalls' as LavaWalls).slide_out()
	
	if float(hp)/max_hp <= 0.75 and states2 != []:
		treshold_reached = 2
	
	if float(hp)/max_hp <= 0.5 and states3 != []:
		treshold_reached = 3
	
	if float(hp)/max_hp <= 0.25 and states4 != []:
		treshold_reached = 4

func _on_Enemy_died():
	pass

const SPEED = 30
var speed_multilplier: int = 1
var velocity: Vector2

var target_reached := false
var delay_finished := false
var callback_ended := false

func do_state():
	while alive:
		if !states[current_state].has('target'):
			target_reached = true
		
		if !states[current_state].has('wait'):
			delay_finished = true
		
		if !states[current_state].has('callback'):
			callback_ended = true
		
		if states[current_state].has('shooting'):
			shooting = states[current_state].shooting
		
		if states[current_state].has('shooting_mode'):
			shooting_mode = states[current_state].shooting_mode
		
		if states[current_state].has('callback'):
			call(states[current_state].callback)
		
		if states[current_state].has('wait'):
			yield(get_tree().create_timer(states[current_state].wait), 'timeout')
			delay_finished = true
		
		if states[current_state].has('speed'):
			speed_multilplier = states[current_state].speed
		
		while !target_reached: yield(get_tree().create_timer(0.01), 'timeout')
		while !delay_finished: yield(get_tree().create_timer(0.01), 'timeout')
		while !callback_ended: yield(get_tree().create_timer(0.01), 'timeout')
		
		if !treshold_reached:
			if states[current_state].has('next'):
				for i in range(0, states.size()):
					if states[i].has('label') and states[i].label == states[current_state].next:
						current_state = i
			elif current_state+1 == states.size():
				current_state = 0
			else:
				current_state += 1
		else:
			match treshold_reached:
				2:
					states = states2
					states2 = []
					print('changed state to 2')
				3:
					states = states3
					states3 = []
					print('changed state to 3')
				4:
					states = states4
					states4 = []
					print('changed state to 4')
			current_state = 0
			treshold_reached = 0
		
		target_reached = false
		delay_finished = false
		callback_ended = false
		
		while Global.time_stopped: yield(get_tree().create_timer(0.01), 'timeout')

func _physics_process(_delta: float) -> void:
	if Global.time_stopped: return
	if states[current_state].has('target'):
		var current_target = states[current_state].target
		current_target *= Vector2(Global.game_width(), Global.game_height())
		if position.distance_to(current_target) > 1:
			velocity = (current_target - position).normalized() * SPEED * speed_multilplier
			velocity = move_and_slide(velocity)
		else:
			target_reached = true


func _on_ShootTimer_timeout():
	if not alive or !shooting or get_node('../Player') == null:
		return
	
	if shooting_mode == 'single':
		var node = EnemyBullet.instance()
		var vel = ((get_node('../Player') as Node2D).position - position).normalized()
		node.init(vel, position, _element)
		$'../Bullets'.add_child(node)
	elif shooting_mode == 'triple':
		for i in range(3):
			var node = EnemyBullet.instance()
			var vel = ((get_node('../Player') as Node2D).position - position + Vector2(i-1, 0)).normalized()
			node.init(vel, position, _element)
			$'../Bullets'.add_child(node)


func set_darkness():
	darkness = true
	yield(get_tree().create_timer(3), 'timeout')
	darkness = false

func time_stopped():
	($AnimatedSprite as AnimatedSprite).playing = false
	while Global.time_stopped: yield(get_tree().create_timer(0.01), 'timeout')
	($AnimatedSprite as AnimatedSprite).playing = true


func _on_Player_died():
	current_state = 0
	states = [
		{ 'shooting': false },
		{ 'target': Vector2(0.5, 0.1) }
	]
	
	do_state()
