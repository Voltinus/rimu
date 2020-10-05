extends Control


func _ready():
	var highscores = Global.get_highscores()
	
	for i in ['fire', 'earth', 'water', 'air', 'dark']:
		var highscore: int = highscores[i + '_highscore']
		var button: Button = get_node('HBoxContainer/Button' + i.capitalize())
		
		button.disabled = highscore == 0
		(button.get_node('AnimatedSprite') as AnimatedSprite).visible = highscore > 0
		(button.get_node('Lock') as Sprite).visible = highscore == 0
