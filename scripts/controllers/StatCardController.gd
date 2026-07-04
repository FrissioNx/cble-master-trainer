extends PanelContainer

@onready var title_label: Label = %CardTitle
@onready var value_label: Label = %CardValue

func set_data(title: String, value: String):
	title_label.text = title
	value_label.text = value
