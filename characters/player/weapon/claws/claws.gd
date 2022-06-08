extends Spatial


enum State {
	RETRACTED,
	EXTENDED,
	RETRACTING,
	EXTENDING,
}

export var _vertical_speed: float
# For throwing moveables around.
export var _throw_power: float

var _current_state = State.RETRACTED


func _physics_process(delta):
	match _current_state:
		State.EXTENDING:
			_extend(delta)
		State.EXTENDED:
			_move_extension(get_owner().get_target())
		State.RETRACTING:
			_retract()


func start_extension():
	# Trigger needs to be reactivated because it is deactivated 
	# on touching environment/returning.
	$Extension/DestroyTrigger/Shape.disabled = false
	$SFX.play()
	_current_state = State.EXTENDING


func _retract():
	var direction = -$Extension.transform.origin
	direction = direction.normalized()
	$Extension.move_and_slide(direction * _vertical_speed)
	
	if $Extension.translation.y >= 0.0: # Gone too far.
		# Fix offset.
		$Extension.translation = Vector3.ZERO
		# Disable so collectibles won't be destroyed.
		$Extension/DestroyTrigger/Shape.disabled = true
		_current_state = State.RETRACTED


func _extend(delta: float):
	var collider = $Extension.move_and_collide(Vector3.DOWN * _vertical_speed * delta)
	
	if collider:
		# Disable collider so it won't be moved around 
		# when extension is extracted, player is flying around
		# and it hits buildings etc.
		#$Extension/Collider.disabled = true
		$RetractTimer.start()
		_set_particle_emission(true)
		_current_state = State.EXTENDED


func _move_extension(target: Vector3):
	var direction = target - $Extension.global_transform.origin
	$Extension.move_and_slide_with_snap(direction, Vector3.DOWN, Vector3.UP)


func _on_RetractTimer_timeout():
	_set_particle_emission(false)
	_current_state = State.RETRACTING


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
