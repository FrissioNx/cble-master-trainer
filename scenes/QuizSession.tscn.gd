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

@onready var title_label: Label = %TitleLabel
@onready var progress_label: Label = %ProgressLabel

@onready var question_label: Label = %QuestionLabel

@onready var choice_a: Button = %ChoiceA
@onready var choice_b: Button = %ChoiceB
@onready var choice_c: Button = %ChoiceC
@onready var choice_d: Button = %ChoiceD

@onready var answer_buttons: Array[Button] = [
	choice_a,
	choice_b,
	choice_c,
	choice_d
]

@onready var submit_button: Button = %SubmitButton

@onready var feedback_label: Label = %FeedbackLabel
@onready var explanation_label: RichTextLabel = %ExplanationLabel

@onready var next_button: Button = %NextButton
@onready var quit_button: Button = %QuitButton
# ==================================================
# Startup
# ==================================================

func _ready():
	print("ROOT CHILDREN:")
	for child in get_children():
		print(child.name)

	print("LOOKING FOR TITLE:")
	print(get_node_or_null("MarginContainer/CenterContainer/QuizCard/CardMargin/VBoxContainer/TitleLabel"))
	randomize()

	title_label.text = "CLBE Master Trainer"
	progress_label.text = ""

	feedback_label.text = ""
	explanation_label.text = ""

	next_button.hide()

	load_questions()
	load_next_question()
	
	
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
	
	
func load_next_question():
	if questions.size() == 0:
		print("ERROR: No questions available.")
		return

	current_question = questions[0]
	selected_answer = -1
	submit_button.disabled = false

	question_label.text = current_question.get("question", "")

	var choices = current_question.get("choices", [])

	for i in range(answer_buttons.size()):
		if i < choices.size():
			answer_buttons[i].text = choices[i]
			answer_buttons[i].show()
		else:
			answer_buttons[i].hide()

	progress_label.text = "Question 1 of %d" % total_questions
	feedback_label.text = ""
	explanation_label.text = ""
	next_button.hide()
	
func select_answer(index: int):
	selected_answer = index

	for i in range(answer_buttons.size()):
		answer_buttons[i].modulate = Color.WHITE

	answer_buttons[index].modulate = Color(0.8, 0.9, 1.0)


func _on_choice_a_pressed():
	select_answer(0)

func _on_choice_b_pressed():
	select_answer(1)

func _on_choice_c_pressed():
	select_answer(2)


func _on_choice_d_pressed():
	select_answer(3)


func _on_submit_button_pressed():
	check_answer()
	
func check_answer():
	if selected_answer == -1:
		feedback_label.text = "Please select an answer."
		return

	var correct_answer = current_question.get("answer", -1)

	if selected_answer == correct_answer:
		score += 1
		feedback_label.text = "✅ Correct!"
		feedback_label.modulate = Color.GREEN
	else:
		feedback_label.text = "❌ Incorrect"
		feedback_label.modulate = Color.RED

	explanation_label.text = current_question.get("explanation", "")

	next_button.show()
	submit_button.disabled = true
