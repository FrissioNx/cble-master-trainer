class_name SaveService
extends RefCounted

const SAVE_PATH := "user://stats.json"

static func save_statistics(data: Dictionary) -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	if file == null:
		push_error("Unable to open save file.")
		return

	file.store_string(JSON.stringify(data, "\t"))
	file.close()


static func load_statistics() -> Dictionary:
	if !FileAccess.file_exists(SAVE_PATH):
		return {}

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)

	if file == null:
		return {}

	var text = file.get_as_text()
	file.close()

	var json = JSON.new()

	if json.parse(text) != OK:
		return {}

	return json.data
