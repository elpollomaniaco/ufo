extends Spatial


export var _rotation_degrees_base: float = 45
var _rotation_degrees: float
var _rotation_direction: float = 1


func _ready():
	_rotation_degrees = _rotation_degrees_base


func _process(delta):
	rotation_degrees.y += _rotation_direction * _rotation_degrees * delta


func _change_rotation_direction():
	_rotation_direction *= -1
	var random_factor = rand_range(0.8, 1.25)
	_rotation_degrees = random_factor * _rotation_degrees_base
	# Keep speed consistent
	$ChangeRotationTimer.set_wait_time(1.0 / random_factor)
	# Start timer manually so new wait time will be used
	$ChangeRotationTimer.start()
