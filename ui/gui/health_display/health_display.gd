extends Control


# Not yet secured against changes in player node!
const MAX_HEALTH: int = 100

onready var _fill: TextureRect = $Fill
onready var _value_label: Label = $Value


func _ready():
	change_value(MAX_HEALTH)


func change_value(new_value: int):
	_change_value_label(new_value)
	_change_fill_size(new_value)


func _change_value_label(health_value: int):
	_value_label.text = str(health_value)


func _change_fill_size(health_value: int):
	var ratio: float = (health_value as float) / (MAX_HEALTH as float)
	_fill.rect_scale = Vector2.ONE * ratio
