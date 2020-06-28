extends Control


func _on_Button_pressed(lang):
	TranslationServer.set_locale(lang)
	Global.goto_scene("MainMenu")
