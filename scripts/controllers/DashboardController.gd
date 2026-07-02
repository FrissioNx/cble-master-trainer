extends PanelContainer

@onready var dashboard_title: Label = %DashboardTitle
@onready var accuracy_label: Label = %AccuracyLabel
@onready var questions_answered_label: Label = %QuestionsAnsweredLabel
@onready var strongest_topic_label: Label = %StrongestTopicLabel
@onready var weakest_topic_label: Label = %WeakestTopicLabel

func _ready():
	refresh_dashboard()

func refresh_dashboard():
	dashboard_title.text = "Study Dashboard"
	accuracy_label.text = "Overall Accuracy: %.1f%%" % StatisticsManager.get_accuracy()
	questions_answered_label.text = "Questions Answered: %d" % StatisticsManager.total_answered

	var strongest = get_strongest_topic()
	var weakest = get_weakest_topic()

	strongest_topic_label.text = "Strongest Topic: %s" % strongest
	weakest_topic_label.text = "Weakest Topic: %s" % weakest

func get_strongest_topic() -> String:
	var best_topic := "--"
	var best_accuracy := -1.0

	for topic in StatisticsManager.get_all_topics():
		var accuracy = StatisticsManager.get_topic_accuracy(topic)
		if accuracy > best_accuracy:
			best_accuracy = accuracy
			best_topic = "%s (%.1f%%)" % [topic, accuracy]

	return best_topic

func get_weakest_topic() -> String:
	var worst_topic := "--"
	var worst_accuracy := 101.0

	for topic in StatisticsManager.get_all_topics():
		var accuracy = StatisticsManager.get_topic_accuracy(topic)
		if accuracy < worst_accuracy:
			worst_accuracy = accuracy
			worst_topic = "%s (%.1f%%)" % [topic, accuracy]

	return worst_topic
