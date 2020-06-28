extends Area2D


var counter = 0
var delay = 0.5


func _ready():
	slide_in()


func _process(delta):
	counter += delta
	if counter >= delay:
		var Player = get_parent().get_node("Player")
		if Player != null and overlaps_body(Player):
			Player.hit(1)
			counter = 0


signal slided

func slide_in():
	for i in range(150):
		position.y = i - 150
		yield(get_tree().create_timer(0.02), "timeout")
	
	emit_signal("slided")


func slide_out():
	for i in range(150):
		position.y = i
		yield(get_tree().create_timer(0.02), "timeout")
	
	self.queue_free()
