extends Control


const MAX_HEALTH: int = 100

export var _orb_health_amount: int

onready var _bar = $Bar
onready var _orb = $Orb/Foreground

func _ready():
	_init_elements()


func change_value(new_value: int):
	if new_value > _orb_health_amount:
		_change_bar_value(new_value)
	else:
		_change_orb_size(new_value)


func _init_elements():
	_bar.max_value = MAX_HEALTH - _orb_health_amount
	_bar.value = _bar.max_value
	_orb.rect_scale = Vector2.ONE


func _change_bar_value(health_value: int):
	_bar.value = health_value - _orb_health_amount


func _change_orb_size(health_value: int):
	_bar.value = 0.0
	var scale: float = health_value as float / _orb_health_amount as float
	_orb.rect_scale = Vector2.ONE * scale
