extends Spatial


export var _base_rotation_degrees: float
export var _base_rotation_time: float
export var _max_random_factor: float

var _rotation_direction: int = -1
var _current_rotation: float

onready var _tween: Tween = $Tween


func _ready():
	_current_rotation = rotation_degrees.y # Starting angle = set in scene.
	_change_rotation_direction() # Start first round.


func _process(_delta):
	rotation_degrees.y = _current_rotation # Set to value calculated by tween.


func _change_rotation_direction():
	_rotation_direction *= -1
	var random_factor = rand_range(1 / _max_random_factor, _max_random_factor)
	# Keep speed constant (hopefully).
	var new_rotation_degrees = _base_rotation_degrees * random_factor
	var rotation_time = _base_rotation_time / random_factor
	
	# warning-ignore:return_value_discarded
	_tween.interpolate_property(self, "_current_rotation", null, _current_rotation + (new_rotation_degrees * _rotation_direction), rotation_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	if not _tween.is_active():
		# warning-ignore:return_value_discarded
		_tween.start()
	
	# Create timer and call function again after countdown.
	var timer = get_tree().create_timer(rotation_time)
	timer.connect("timeout", self, "_change_rotation_direction")
