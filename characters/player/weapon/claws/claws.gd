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
			_extend()
		State.EXTENDED:
			_move_extension(Vector3.ZERO, delta)
		State.RETRACTING:
			_retract()


func extend():
	# Needs to be reactivated because it is deactivated 
	# on touching environment/returning.
	$Extension/Collider.disabled = false
	$Extension/DestroyTrigger/Shape.disabled = false
	$SFX.play()


func _retract():
	pass


func _extend():
	pass


func _move_extension(target: Vector3, delta: float):
	pass


func _on_collision():
	# Disable collider so it won't be moved around 
	# when extension is extracted, player is flying around
	# and it hits buildings etc.
	#$Extension/Collider.disabled = true
	$RetractTimer.start()
	_set_particle_emission(true)


func _on_return():
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
