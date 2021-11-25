extends Control


export var _min_orb_scale: float

var _current_orb: int

onready var _bar = $Bar
onready var _health_orbs: Array = $Orbs.get_children()
onready var _health_per_orb: float = 100.0 / _health_orbs.size()


func _ready():
	_init_elements()


func change_value(new_value: int):
	_change_bar_value(new_value)
	_change_orb_size(new_value)


func _init_elements():
	_bar.max_value = _health_per_orb
	_bar.value = _bar.max_value
	for orb in _health_orbs:
		orb.rect_scale = Vector2.ONE
	_current_orb = _health_orbs.size()


func _change_bar_value(new_value: int):
	var value: float = fmod(new_value, _health_per_orb)
	_bar.value = value


func _change_orb_size(new_value: int):
	var orb_number: int = (new_value / _health_per_orb) as int + 1
	var scale: float = fmod(new_value, _health_per_orb) / _health_per_orb
	_health_orbs[-orb_number].rect_scale = Vector2.ONE * max(scale, _min_orb_scale)
	if orb_number < _current_orb:
		_health_orbs[-_current_orb].hide()
		_current_orb = orb_number
