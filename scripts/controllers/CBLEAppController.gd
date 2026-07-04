extends Control

@onready var home_page: Control = %HomePage
@onready var quiz_page: Control = %QuizPage
@onready var results_page: Control = %ResultsPage
@onready var statistics_page: Control = %StatisticsPage
@onready var forecast_page: Control = %ForecastPage

func _ready():
	show_page(home_page)

func show_page(page_to_show: Control):
	var pages = [
		home_page,
		quiz_page,
		results_page,
		statistics_page,
		forecast_page
	]

	for page in pages:
		page.hide()

	page_to_show.show()

func _on_practice_button_pressed():
	SessionManager.start_practice_mode()
	SessionManager.selection_mode = SessionManager.SelectionMode.RANDOM
	get_tree().change_scene_to_file("res://scenes/quiz/QuizSession.tscn")


func _on_weak_areas_button_pressed():
	SessionManager.start_practice_mode()
	SessionManager.selection_mode = SessionManager.SelectionMode.WEAK_AREAS
	get_tree().change_scene_to_file("res://scenes/quiz/QuizSession.tscn")


func _on_exam_button_pressed():
	SessionManager.start_exam_mode()
	SessionManager.selection_mode = SessionManager.SelectionMode.RANDOM
	get_tree().change_scene_to_file("res://scenes/quiz/QuizSession.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
