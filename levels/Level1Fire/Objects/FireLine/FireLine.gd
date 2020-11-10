extends Area2D


var time_before = 3             # Time in seconds before fire line gets ignited
var time_after = 3              # Time in seconds after the line starts to fade out
var time_fade_out = 1           # Time in seconds of the line fading out
const fade_out_precision = 10   # Fade out precision, how many steps would fade out take


func init(props = {}):
	if props.has('time_before'):
		time_before = props.time_before
	if props.has('time_after'):
		time_after = props.time_after
	if props.has('time_fade_out'):
		time_fade_out = props.time_fade_out
	
	yield(get_tree().create_timer(time_before), "timeout")
	($AnimatedSprite  as AnimatedSprite).play("fire")
	($AnimatedSprite2 as AnimatedSprite).play("fire")
	burning = true
	
	if time_after == -1:
		while time_after == -1:
			yield(get_tree().create_timer(0.1), "timeout")
	else:
		yield(get_tree().create_timer(time_after), "timeout")
	
	for i in range(fade_out_precision):
		var color = Color.white
		color.a = (fade_out_precision-i)/float(fade_out_precision)
		modulate = color
		yield(get_tree().create_timer(time_fade_out/float(fade_out_precision)), "timeout")
	self.queue_free()

func enemy_died():
	time_after = 0


var burning = false    # States if line is on fire
var accumulator = 0    # Accumulator for gathering delta, until in exceeds the INTERVAL
const INTERVAL = 0.2   # Interval in seconds in which player should take damage

func _physics_process(delta):
	accumulator += delta
	if accumulator >= INTERVAL and player_inside and burning:
		player.hit(1)
		accumulator = 0


var player
var player_inside = false   # Indicates if player is inside Area2D

func _on_FireLine_body_entered(body):
	if body.name == "Player":
		player_inside = true
		player = body

func _on_FireLine_body_exited(body):
	if body.name == "Player":
		player_inside = false
