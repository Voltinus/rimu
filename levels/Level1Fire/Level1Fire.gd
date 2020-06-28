extends "res://templates/Level/Level.gd"


func _is_enemy_alive():
	return $Game/Enemy.alive


func _ready():
	.init("fire")
