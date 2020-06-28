extends Control


func _on_ButtonExit_pressed():
	Global.quit()

func _on_ButtonNewGame_pressed():
	Global.goto_scene("Story")
