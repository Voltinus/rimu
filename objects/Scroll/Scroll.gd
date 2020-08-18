extends Area2D
class_name Scroll


var _element: String

const gradients = {
	"fire":  [ Color(1, 1, 0.33), Color(1, 0.33, 0, 0.5) ],
	"earth": [ Color(0, 0.66, 0), Color(0, 0.33, 0, 0.5) ],
	"water": [ Color(1, 1, 1),    Color(1, 1, 1, 0.25) ],
	"air":   [ Color(1, 1, 0.5),  Color(1, 1, 1, 0.25) ],
	"dark":  [ Color(1, 1, 1),    Color(1, 1, 1, 0.25) ]
}

func init(elem: String):
	_element = elem
	($Sprite as Sprite).texture = load("res://objects/Scroll/scroll_%s.png" % elem)
	((($Particles2D as Particles2D).process_material as ParticlesMaterial).color_ramp as GradientTexture).gradient.colors = PoolColorArray(gradients[elem])


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
