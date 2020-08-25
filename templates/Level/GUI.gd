extends Control
class_name GUI


const BOSS_NAMES = {
	"fire": "Feren",
	"water": "Vada",
	"air": "Aria",
	"earth": "Lili",
	"dark": "Darek'h"
}

const BOSS_BAR_COLORS = {
	"fire":  Color.red,
	"water": Color.blue,
	"air":   Color.goldenrod,
	"earth": Color.limegreen,
	"dark":  Color.purple
}


func init(elem: String) -> void:
	($BossStats/Name as Label).text = BOSS_NAMES[elem]
	($BossStats/HPBar as TextureRect).modulate = BOSS_BAR_COLORS[elem]
