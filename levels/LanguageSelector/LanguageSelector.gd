extends Control


func _on_Button_pressed(lang: String) -> void:
	TranslationServer.set_locale(lang)
	Global.goto_scene("MainMenu")
