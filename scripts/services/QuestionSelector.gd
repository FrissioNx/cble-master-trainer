class_name QuestionSelector
extends RefCounted

static func get_next_question(remaining_questions: Array) -> Dictionary:
	if remaining_questions.is_empty():
		return {}

	match SessionManager.selection_mode:
		SessionManager.SelectionMode.WEAK_AREAS:
			return get_weak_area_question(remaining_questions)
		_:
			return get_random_question(remaining_questions)


static func get_random_question(remaining_questions: Array) -> Dictionary:
	return remaining_questions.pop_front()


static func get_weak_area_question(remaining_questions: Array) -> Dictionary:
	var weakest_question_index := 0
	var weakest_score := 101.0

	for i in range(remaining_questions.size()):
		var question = remaining_questions[i]
		var tags = question.get("tags", [])
		var question_score = get_question_topic_score(tags)

		if question_score < weakest_score:
			weakest_score = question_score
			weakest_question_index = i

	return remaining_questions.pop_at(weakest_question_index)


static func get_question_topic_score(tags: Array) -> float:
	if tags.is_empty():
		return 100.0

	var total := 0.0

	for tag in tags:
		total += StatisticsManager.get_topic_accuracy(tag)

	return total / float(tags.size())
