extends Control


func _on_ButtonMainMenu_pressed():
	Global.goto_scene("MainMenu")

func _on_ButtonExit_pressed():
	Global.quit()
