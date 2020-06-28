extends Control

enum states {
	STORY1, STORY2
}

var current_state = states.STORY1


func _ready():
	$Label.text  = "  " + tr("STORY1") + "\n  " + tr("STORY2")
	$Label2.text = "  " + tr("STORY3") + "\n  " + tr("STORY4")


func _input(event):
	if event.is_action_pressed("dialogue_skip"):
		match current_state:
			states.STORY1:
				current_state = states.STORY2
				$Label.hide()
				$Label2.show()
			states.STORY2:
				Global.goto_scene("Dialogue1FerenBefore")
