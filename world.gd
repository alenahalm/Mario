extends Node2D


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://main.tscn")
		if event.pressed and event.keycode == 80:
			Global.pause = true
			get_tree().change_scene_to_file("res://pause.tscn")

func _on_constrict_body_exited(body):
	if body.name.begins_with("Enemy"):
		body.go_left = !body.go_left


func _on_ending_animation_body_entered(body):
	if body.name == "Player":
		body.end = true
		body.score += int(($UI/Time/Timer).time_left)
		($UI/Time/Timer).paused = true

func _on_ending_animation_body_exited(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://game_over.tscn")
