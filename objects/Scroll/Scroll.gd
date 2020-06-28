extends Area2D


var _element : String

func init(elem):
	_element = elem
	$Sprite.texture = load("res://objects/Scroll/scroll_%s.png" % elem)


var next_scene = {
	"fire":  "Dialogue2FerenAfter",
	"earth": "Dialogue4LiliAfter",
	"water": "Dialogue6VadaAfter",
	"air":   "Dialogue8AriaAfter",
	"dark":  "Dialogue10DarekhAfter"
}

func _on_Scroll_body_entered(body):
	if body.name == "Player":
		Global.goto_scene(next_scene[_element])
