extends Node2D


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://main.tscn")
		if event.pressed and event.keycode == 80:
			Global.pause = !Global.pause
			get_tree().change_scene_to_file("res://world.tscn")
