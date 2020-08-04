extends Control


const BOSS_NAMES = {
	"fire": "Feren",
	"water": "Vada",
	"air": "Aria",
	"earth": "Lili",
	"dark": "Darek'h"
}

const BOSS_BAR_COLORS = {
	"fire":  Color.gold,
	"water": Color.blue,
	"air":   Color.goldenrod,
	"earth": Color.limegreen,
	"dark":  Color.purple
}


func init(elem):
	$BossStats/Name.text = BOSS_NAMES[elem]
	$BossStats/HPBar.modulate = BOSS_BAR_COLORS[elem]
