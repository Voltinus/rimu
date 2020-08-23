extends Area2D
class_name Book


const SPEED: int = 50


var _element: String


func _ready():
	_element = ["fire", "water", "air", "dark"][randi()%4]
	match _element:
		"fire":  ($Sprite as Sprite).frame = 0
		"water": ($Sprite as Sprite).frame = 1
		"air":   ($Sprite as Sprite).frame = 2
		"dark":  ($Sprite as Sprite).frame = 3

func _physics_process(delta: float) -> void:
	position += Vector2(0, 1) * delta * SPEED
	if position.y > Global.game_height() + 5:
		self.queue_free()


func _on_Book_body_entered(body):
	if body.name == "Player":
		body.powerup("book", _element)
		self.queue_free()
