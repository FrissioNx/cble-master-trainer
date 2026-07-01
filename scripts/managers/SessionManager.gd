extends Node

enum QuizMode {
	PRACTICE,
	EXAM,
	REVIEW
}

var current_mode: QuizMode = QuizMode.PRACTICE

var current_score := 0
var current_question := 0
var total_questions := 0

func reset_session():
	current_score = 0
	current_question = 0
	total_questions = 0

func start_practice_mode():
	reset_session()
	current_mode = QuizMode.PRACTICE
	total_questions = 10

func start_exam_mode():
	reset_session()
	current_mode = QuizMode.EXAM
	total_questions = 80
