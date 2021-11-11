extends Area


const PULL_FORCE: int = 1000;

# Energy drained per second while activated.
export var _energy_drain: float

var _targets: Array


func _physics_process(delta):
	if get_owner().try_to_drain_energy(_energy_drain * delta):
		_attract_targets()
	else:
		_force_deactivate_tractor_beam()


func activate():
	show()
	set_physics_process(true)


func deactivate():
	set_physics_process(false)
	hide()


func _on_TractorBeam_body_entered(body):
	_targets.append(body)


func _on_TractorBeam_body_exited(body):
	_targets.erase(body)


func _attract_targets():
	for target in _targets:
		target.add_central_force(Vector3.UP * PULL_FORCE)


func _force_deactivate_tractor_beam():
	hide()
	set_physics_process(false)
	# TODO: Some fancy "no more energy" stuff
