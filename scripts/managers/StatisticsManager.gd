extends Node

var total_answered := 0
var total_correct := 0

var topic_stats := {}

func reset():
	total_answered = 0
	total_correct = 0
	topic_stats.clear()

func record_answer(tags: Array, correct: bool):
	total_answered += 1

	if correct:
		total_correct += 1

	for tag in tags:

		if !topic_stats.has(tag):
			topic_stats[tag] = {
				"correct": 0,
				"wrong": 0
			}

		if correct:
			topic_stats[tag]["correct"] += 1
		else:
			topic_stats[tag]["wrong"] += 1

func get_accuracy():
	if total_answered == 0:
		return 0.0

	return (float(total_correct) / float(total_answered)) * 100.0

func get_topic_accuracy(tag:String):

	if !topic_stats.has(tag):
		return 0.0

	var c = topic_stats[tag]["correct"]
	var w = topic_stats[tag]["wrong"]

	if c + w == 0:
		return 0.0

	return (float(c) / float(c + w)) * 100.0

func get_all_topics():
	return topic_stats.keys()
