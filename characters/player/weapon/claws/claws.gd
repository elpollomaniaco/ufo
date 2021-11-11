extends Spatial


const SPEED: float = 50.0
const MOVEMENT = {
	"UP": 1,
	"DOWN": -1,
	"STOP": 0,
}

var _current_movement: int = MOVEMENT.STOP


func _physics_process(delta):
	if _current_movement != MOVEMENT.STOP:
		_move_extension(delta, _current_movement)


func extend():
	# Needs to be reactivated because it is deactivated on touching environment.
	$Extension/Collider.disabled = false
	_current_movement = MOVEMENT.DOWN


func _retract():
	_current_movement = MOVEMENT.UP


func _on_collision():
	# Disable collider so it won't be moved around 
	# when extension is extracted, player is flying around
	# and it hits buildings etc.
	$Extension/Collider.disabled = true
	_retract()


func _on_return():
	_current_movement = MOVEMENT.STOP
	$Extension.translation.y = 0
	

func _move_extension(delta: float, direction: int):
	var collision = $Extension.move_and_collide(Vector3.UP * direction * SPEED * delta)
	
	if collision:
		_on_collision()
	if direction == MOVEMENT.UP and $Extension.translation.y >= 0.0:
		_on_return()
