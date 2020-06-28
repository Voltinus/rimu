extends "res://actors/Enemy/Enemy.gd"


var LavaWalls = preload("res://objects/LavaWalls/LavaWalls.tscn")
var FireLine  = preload("res://objects/FireLine/FireLine.tscn")


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
			for _i in range(3):
				for _j in range(5):
					if not alive or state != "BURSTING":
						return
					burst(24)
					yield(get_tree().create_timer(0.15), "timeout")
				yield(get_tree().create_timer(0.5), "timeout")
				
			next_state_name = "MOVING_LEFT"
		"PREPARING_TO_SPAWN_LAVA":
			target = Vector2(60, 20)
			next_state_name = "SPAWNING_LAVA"
		"SPAWNING_LAVA":
			var node = LavaWalls.instance()
			get_parent().add_child(node)
			yield(node, "slided")
			next_state_name = "IDLING"


var time_elapsed = 0            # Time that elapsed from spawning the enemy, set to 0 after every FIRE_LINE_INTERVAL seconds
const FIRE_LINE_INTERVAL = 15   # Time in seconds between spawnin every set of fire lines
const FIRE_LINE_DELAY    = 0.5  # Time in seconds between spawning lines within the set
const FILE_LINE_COUNT    = 3    # Number of lines within the set of lines

func _physics_process(delta):
	time_elapsed += delta
	
	if time_elapsed >= FIRE_LINE_INTERVAL:
		time_elapsed = 0
		for _i in range(FILE_LINE_COUNT):
			var node = FireLine.instance()
			node.position.x = 60
			node.position.y = int(rand_range(50, 130))
			get_parent().add_child(node)
			yield(get_tree().create_timer(FIRE_LINE_DELAY), "timeout")


func _on_Enemy_hitted(hp_left):
	if hp_left == 0.5:
		next_state_name = "PREPARING_TO_SPAWN_LAVA"


func _on_Enemy_died():
	get_parent().get_node("LavaWalls").slide_out()
