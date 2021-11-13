extends Spatial


const MOVEMENT = {
	"UP": 1,
	"DOWN": -1,
	"STOP": 0,
}

export var _vertical_speed: float
# For throwing moveables around.
export var _throw_power: float

var _current_movement: int = MOVEMENT.STOP


func _physics_process(delta):
	if _current_movement != MOVEMENT.STOP:
		_move_extension(delta, _current_movement)


func extend():
	# Needs to be reactivated because it is deactivated 
	# on touching environment/returning.
	$Extension/Collider.disabled = false
	$Extension/DestroyTrigger/Shape.disabled = false
	_current_movement = MOVEMENT.DOWN


func _retract():
	_current_movement = MOVEMENT.UP
	_set_particle_emission(false)


func _move_extension(delta: float, direction: int):
	var collision = $Extension.move_and_collide(Vector3.UP * direction * _vertical_speed * delta)
	
	if collision:
		_on_collision()
	if direction == MOVEMENT.UP and $Extension.translation.y >= 0.0:
		_on_return()


func _on_collision():
	# Disable collider so it won't be moved around 
	# when extension is extracted, player is flying around
	# and it hits buildings etc.
	#$Extension/Collider.disabled = true
	_current_movement = MOVEMENT.STOP
	$RetractTimer.start()
	_set_particle_emission(true)


func _on_return():
	_current_movement = MOVEMENT.STOP
	# Fix offset.
	$Extension.translation = Vector3.ZERO
	# Disable so collectibles won't be destroyed.
	$Extension/DestroyTrigger/Shape.disabled = true


func _on_RetractTimer_timeout():
	_retract()


func _on_DestroyTrigger_body_entered(body):
	if body.has_method("destroy"):
		body.destroy()
	else:
		# Just destroy if there is no controlled method.
		# Collision layers should never register anything that 
		# must not be destroyed.
		body.queue_free()


func _on_MoveablesTrigger_body_entered(body):
	body.apply_central_impulse(Vector3.UP * _throw_power)


func _set_particle_emission(emit: bool):
	$Extension/Particles/Dust.emitting = emit
	$Extension/Particles/Glyphs.emitting = emit
