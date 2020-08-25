extends Area2D
class_name Book


const SPEED: int = 50

var _type: String
export var frozen := false

const BOOK_TYPES = [
	'fire',
	'earth',
	'water',
	'air',
	'dark',
	'white',
	'black',
	'gray'
]

func init(freeze: bool = false):
	frozen = freeze
	var book_type = randi()%BOOK_TYPES.size()
	_type = BOOK_TYPES[book_type]
	($Sprite as Sprite).frame = book_type

func _ready():
	init()

func _physics_process(delta: float) -> void:
	if frozen:
		print('book is frozen, ' + name)
		return
	position += Vector2(0, 1) * delta * SPEED
	if position.y > Global.game_height() + 5:
		self.queue_free()


func _on_Book_body_entered(body):
	if body.name == 'Player':
		(get_tree().get_nodes_in_group('book_slot')[0] as AnimatedSprite).play(_type)
		Global.player_book = _type
		self.queue_free()
