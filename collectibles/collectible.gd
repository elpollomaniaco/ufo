extends RigidBody


signal collectible_vanished

export var _points: int
export var _energy_charge: float


func destroy():
	emit_signal("collectible_vanished")
	queue_free()


func collect() -> int:
	emit_signal("collectible_vanished")
	queue_free()
	return _points


func get_energy_charge() -> float:
	return _energy_charge
