extends Control


func _ready():
	$Label.text  = "  " + tr("STORY1")
	$Label.text += "\n  " + tr("STORY2")
	$Label.text += "\n  " + tr("STORY3")
	$Label.text += "\n  " + tr("STORY4")


func _input(event):
	if event.is_action_pressed("dialogue_skip"):
		Global.goto_scene("Dialogue1FerenBefore")
