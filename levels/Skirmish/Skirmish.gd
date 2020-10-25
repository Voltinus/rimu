extends Control


func _ready():
	for i in ['fire', 'earth', 'water', 'air', 'dark']:
		var highscore: int = Global.highscores[i + '_highscore']
		var button: Button = get_node('HBoxContainer/Button' + i.capitalize())
		
		button.disabled = highscore == 0
		(button.get_node('AnimatedSprite') as AnimatedSprite).visible = highscore > 0
		(button.get_node('Lock') as Sprite).visible = highscore == 0


func _on_ButtonFire_pressed():  Global.goto_scene('Level1Fire')
func _on_ButtonEarth_pressed(): Global.goto_scene('Level2Earth')
func _on_ButtonWater_pressed():	Global.goto_scene('Level3Water')
func _on_ButtonAir_pressed():   Global.goto_scene('Level4Air')
func _on_ButtonDark_pressed():  Global.goto_scene('Level5Dark')

func _on_Return_pressed():      Global.goto_scene('MainMenu')
