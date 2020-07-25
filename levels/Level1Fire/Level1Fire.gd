extends "res://templates/Level/Level.gd"

export var lava_walls : Resource = null

func _is_enemy_alive():
	return $Game/Enemy.alive


func _ready():
	.init("fire")
