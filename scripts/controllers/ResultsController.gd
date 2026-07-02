extends Control

@onready var title_label: Label = get_node_or_null("%TitleLabel")
@onready var score_label: Label = get_node_or_null("%ScoreLabel")
@onready var result_label: Label = get_node_or_null("%ResultLabel")
@onready var summary_label: Label = get_node_or_null("%SummaryLabel")
@onready var main_menu_button: Button = get_node_or_null("%MainMenuButton")

func _ready():
	
	if title_label == null:
		print("Missing TitleLabel")
		return
	if score_label == null:
		print("Missing ScoreLabel")
		return
	if result_label == null:
		print("Missing ResultLabel")
		return
	if summary_label == null:
		print("Missing SummaryLabel")
		return

	title_label.text = "Results"

	var total = max(SessionManager.total_questions, 1)

	score_label.text = "Score: %d / %d" % [
		SessionManager.current_score,
		total
	]

	if SessionManager.current_mode == SessionManager.QuizMode.EXAM:
		var percent = float(SessionManager.current_score) / float(total)

		if percent >= 0.75:
			result_label.text = "PASS"
		else:
			result_label.text = "FAIL"

		summary_label.text = build_topic_summary()
	else:
		result_label.text = "Practice Complete"
		summary_label.text = build_topic_summary()

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/MainMenu.tscn")
	
func build_topic_summary() -> String:
	var lines = []

	lines.append("Accuracy: %.1f%%" % StatisticsManager.get_accuracy())
	lines.append("")
	lines.append("Topic Performance:")

	var topics = StatisticsManager.get_all_topics()

	if topics.size() == 0:
		lines.append("No topic data recorded yet.")
		return "\n".join(lines)

	for topic in topics:
		var accuracy = StatisticsManager.get_topic_accuracy(topic)
		lines.append("- %s: %.1f%%" % [topic, accuracy])

	return "\n".join(lines)
