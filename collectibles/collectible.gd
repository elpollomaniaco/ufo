extends RigidBody


signal collectible_vanished

export var _points: int
export var _energy_charge: float


func destroy():
	emit_signal("collectible_vanished")
	queue_free()


func collect() -> Dictionary:
	emit_signal("collectible_vanished")
	queue_free()
	
	var collection = {
		"Points": _points,
		"Energy": _energy_charge
	}
	return collection
