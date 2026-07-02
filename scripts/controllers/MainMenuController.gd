extends Control

func _on_practice_button_pressed():
	SessionManager.start_practice_mode()
	SessionManager.selection_mode = SessionManager.SelectionMode.RANDOM
	get_tree().change_scene_to_file("res://scenes/quiz/QuizSession.tscn")

func _on_exam_button_pressed():
	SessionManager.start_exam_mode()
	get_tree().change_scene_to_file("res://scenes/quiz/QuizSession.tscn")

func _on_exit_button_pressed():
	get_tree().quit()

func _on_weak_areas_button_pressed():
	SessionManager.start_practice_mode()
	SessionManager.selection_mode = SessionManager.SelectionMode.WEAK_AREAS
	get_tree().change_scene_to_file("res://scenes/quiz/QuizSession.tscn")
