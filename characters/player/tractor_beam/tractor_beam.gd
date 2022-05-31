extends Area


# Energy drained per second while activated.
export var _energy_drain: float
export var _pull_force: int

var _targets: Array
var _is_active: bool = false


func _physics_process(delta):
	if _is_active:
		if owner.try_to_drain_energy(_energy_drain * delta):
			_attract_targets()
		else:
			_force_deactivate_tractor_beam()


func activate():
	show()
	_is_active = true
	$SFX.play()


func deactivate():
	_is_active = false
	$SFX.stop()
	hide()


func _on_TractorBeam_body_entered(body):
	_targets.append(body)


func _on_TractorBeam_body_exited(body):
	_targets.erase(body)


func _attract_targets():
	for target in _targets:
		# Attract towards ufo (owner).
		var direction = owner.global_transform.origin - target.global_transform.origin
		direction = direction.normalized()
		target.add_central_force(direction * _pull_force)


func _force_deactivate_tractor_beam():
	# TODO: Some fancy "no more energy" stuff
	deactivate()
