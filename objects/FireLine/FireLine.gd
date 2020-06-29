extends Area2D


const TIME_BEFORE = 3           # Time in seconds before fire line gets ignited
const TIME_AFTER = 3            # Time in seconds after the line starts to fade out
const TIME_FADE_OUT = 1         # Time in seconds of the line fading out
const FADE_OUT_PRECISION = 10   # Fade out precision, how many steps would fade out take

func _ready():
	yield(get_tree().create_timer(TIME_BEFORE), "timeout")
	$AnimatedSprite.play("fire")
	burning = true
	yield(get_tree().create_timer(TIME_AFTER), "timeout")
	for i in range(FADE_OUT_PRECISION):
		var color = Color.white
		color.a = (FADE_OUT_PRECISION-i)/float(FADE_OUT_PRECISION)
		modulate = color
		yield(get_tree().create_timer(TIME_FADE_OUT/float(FADE_OUT_PRECISION)), "timeout")
	self.queue_free()



var burning = false    # States if line is on fire
var accumulator = 0    # Accumulator for gathering delta, until in exceeds the INTERVAL
const INTERVAL = 0.5   # Interval in seconds in which player should take damage

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
