extends Area2D


const time_before = 3           # Time in seconds before fire line gets ignited
const time_after = 3            # Time in seconds after the line starts to fade out
const time_fade_out = 1         # Time in seconds of the line fading out
const fade_out_precision = 10   # Fade out precision, how many steps would fade out take

func _ready():
	yield(get_tree().create_timer(time_before), "timeout")
	($AnimatedSprite as AnimatedSprite).play("fire")
	burning = true
	yield(get_tree().create_timer(time_after), "timeout")
	for i in range(fade_out_precision):
		var color = Color.white
		color.a = (fade_out_precision-i)/float(fade_out_precision)
		modulate = color
		yield(get_tree().create_timer(time_fade_out/float(fade_out_precision)), "timeout")
	self.queue_free()


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
