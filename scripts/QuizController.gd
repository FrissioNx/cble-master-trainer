extends Control

# ==================================================
# CLBE MASTER TRAINER 2.0
# Quiz Controller
# ==================================================

# ---------- Configuration ----------

enum QuizMode {
	PRACTICE,
	EXAM
}

@export var quiz_mode : QuizMode = QuizMode.PRACTICE
@export var total_questions : int = 10

# ---------- Data ----------

var questions : Array = []
var current_question : Dictionary = {}

var current_question_number : int = 0
var score : int = 0

# ---------- Topic Statistics ----------

var topic_stats : Dictionary = {}

# ---------- Player ----------

var selected_answer : int = -1

# ---------- UI References ----------

@onready var title_label = $"MarginContainer/VBoxContainer/TitleLabel"
@onready var progress_label = $"MarginContainer/VBoxContainer/ProgressLabel"

@onready var question_label = $"MarginContainer/VBoxContainer/QuestionPanel/QuestionLabel"

@onready var answer_buttons = [
	$"MarginContainer/VBoxContainer/AnswersContainer/ChoiceA",
	$"MarginContainer/VBoxContainer/AnswersContainer/ChoiceB",
	$"MarginContainer/VBoxContainer/AnswersContainer/ChoiceC",
	$"MarginContainer/VBoxContainer/AnswersContainer/ChoiceD"
]

@onready var submit_button = $"MarginContainer/VBoxContainer/SubmitButton"
@onready var feedback_label = $"MarginContainer/VBoxContainer/FeedbackLabel"
@onready var explanation_label = $"MarginContainer/VBoxContainer/ExplanationLabel"

@onready var next_button = $"MarginContainer/VBoxContainer/BottomBar/NextButton"
@onready var quit_button = $"MarginContainer/VBoxContainer/BottomBar/QuitButton"

# ==================================================
# Startup
# ==================================================

func _ready():
	print("QuizController 2.0 is running")
	randomize()

	title_label.text = "CLBE Master Trainer"
	progress_label.text = ""

	feedback_label.text = ""
	explanation_label.text = ""

	next_button.hide()

	load_questions()
	
	
	
func load_questions():
	var file = FileAccess.open("res://data/questions.json", FileAccess.READ)

	if file == null:
		print("ERROR: Could not open questions.json")
		return

	var text = file.get_as_text()

	var json = JSON.new()
	var result = json.parse(text)

	if result != OK:
		print("ERROR: JSON parse failed: ", json.get_error_message())
		return

	questions = json.data

	print("Questions loaded: ", questions.size())
	
	
	
