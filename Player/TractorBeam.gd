extends Area


export var force: int = 1000;
export var energy_drain: float = 5.0;

var _targets: Array


func _physics_process(delta):
	if get_owner().try_to_drain_energy(energy_drain * delta):
		_attract_targets()
	else:
		_force_deactivate_tractor_beam()


func _on_TractorBeam_body_entered(body):
	_targets.append(body)


func _on_TractorBeam_body_exited(body):
	_targets.erase(body)


func _attract_targets():
	for target in _targets:
		target.add_central_force(Vector3.UP * force)


func _force_deactivate_tractor_beam():
	hide()
	set_physics_process(false)
	# TODO: Some fancy "no more energy" stuff
