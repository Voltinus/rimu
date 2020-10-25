extends Control


onready var color_rect = $"CanvasLayer/ColorRect"


func change_scene(scn: String) -> void:
	get_tree().paused = true
	
	color_rect.color = Color(0, 0, 0, 0)
	
	for i in range(10):
		color_rect.color = Color(0, 0, 0, i/9.0)
		yield(get_tree().create_timer(0.01), "timeout")
	
	if get_tree().change_scene("res://levels/%s/%s.tscn" % [scn, scn]) != OK:
		print("Changing scene not OK!")
	
	color_rect.color = Color(0, 0, 0, 1)
	
	for i in range(10):
		color_rect.color = Color(0, 0, 0, 1 - i/9.0)
		yield(get_tree().create_timer(0.01), "timeout")
	
	get_tree().paused = false


func _on_ColorRect_gui_input(event):
	print(event)
