extends Control


func _ready():
	($Label as Label).text = "  " + tr("STORY1")
	($Label as Label).text += "\n  " + tr("STORY2")
	($Label as Label).text += "\n  " + tr("STORY3")
	($Label as Label).text += "\n  " + tr("STORY4")


func _input(event: InputEvent):
	if event.is_action_pressed("dialogue_skip"):
		Global.goto_scene("Dialogue1FerenBefore")
