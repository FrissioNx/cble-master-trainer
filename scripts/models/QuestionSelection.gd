class_name QuestionSelection
extends RefCounted

var question: Dictionary = {}
var reason: String = ""
var strategy: String = ""

func _init(
	_question: Dictionary = {},
	_reason: String = "",
	_strategy: String = ""
):
	question = _question
	reason = _reason
	strategy = _strategy
