extends Area


export var power: int = 100;

var _targets: Array


func _physics_process(delta):
	_attract_targets()


func _on_TractorBeam_body_entered(body):
	_targets.append(body)


func _on_TractorBeam_body_exited(body):
	_targets.erase(body)


func _attract_targets():
	for target in _targets:
		target.add_central_force(Vector3.UP * power)
