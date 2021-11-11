extends Spatial


const BASE_ROTATION_DEGREES: int = 45

var _rotation_direction: int = 1
# Set for first cycle.
var _rotation_degrees: float = BASE_ROTATION_DEGREES


func _process(delta):
	rotation_degrees.y += _rotation_direction * _rotation_degrees * delta


func _change_rotation_direction():
	_rotation_direction *= -1
	var random_factor = rand_range(0.8, 1.25)
	_rotation_degrees = random_factor * BASE_ROTATION_DEGREES
	
	# Keep speed consistent (hopefully).
	$ChangeRotationTimer.set_wait_time(1.0 / random_factor)
	# Start timer manually so new wait time will be used.
	$ChangeRotationTimer.start()
