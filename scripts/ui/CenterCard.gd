extends Control

@export var target_width: float = 780.0
@export var target_height: float = 520.0

func _ready():
	resized.connect(_center_card)
	_center_card()

func _center_card():
	var viewport_size = get_viewport_rect().size
	size = Vector2(target_width, target_height)
	position = (viewport_size - size) / 2.0
