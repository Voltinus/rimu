extends Area2D


func _ready():
	pass

func _physics_process(delta: float) -> void:
	pass


func _on_Book_body_entered(body):
	if body.name == "Player":
		print("picked up a book")
		self.queue_free()
