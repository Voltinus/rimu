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


func update_boss_stats(hp_left: float) -> void:
	($BossStats/HPBar as TextureRect).rect_size.x = hp_left * Global.game_width()


func update_player_stats(hp_left: float, hp_runes: int = 0, attack_runes: int = 0) -> void:
	($PlayerStats/HP/HPBar as TextureProgress).value = int(hp_left * 100)
	for i in range(3):
		($PlayerStats/HPRunes.get_node('Rune' + str(i+1)) as TextureRect).visible = i < hp_runes
	for i in range(5):
		($PlayerStats/AttackRunes.get_node('Rune' + str(i+1)) as TextureRect).visible = i < attack_runes


func _on_Player_stats_changed(hp_left, hp_runes, attack_runes):
	update_player_stats(hp_left, hp_runes, attack_runes)


func _on_Player_died():
	if not $GameOver.visible:
		$GameOver.visible = true
		$GameOver/AnimationPlayer.play('red_to_black')


func _on_Retry_pressed():
	get_tree().reload_current_scene()


func _on_MainMenu_pressed():
	Global.goto_scene('MainMenu')
