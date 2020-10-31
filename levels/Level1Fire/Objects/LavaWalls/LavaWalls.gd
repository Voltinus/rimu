extends Area2D
class_name LavaWalls


var counter := 0.0
var delay := 0.5


func _ready():
	slide_in()


func _process(delta):
	counter += delta
	if player_inside and counter >= delay:
		get_tree().call_group('player', 'hit', 1)
		counter = 0


signal slided

func slide_in():
	for i in range(Global.game_height()):
		while Global.time_stopped: yield(get_tree().create_timer(0.01), 'timeout')
		position.y = i - Global.game_height()
		yield(get_tree().create_timer(0.01), "timeout")
	
	emit_signal("slided")


func slide_out():
	for i in range(Global.game_height()):
		while Global.time_stopped: yield(get_tree().create_timer(0.01), 'timeout')
		position.y = i
		yield(get_tree().create_timer(0.01), "timeout")
	
	self.queue_free()


var player_inside = false


func _on_LavaWalls_body_entered(body):
	if body.name == 'Player':
		player_inside = true


func _on_LavaWalls_body_exited(body):
	if body.name == 'Player':
		player_inside = false
