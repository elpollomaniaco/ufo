extends RigidBody


signal collectible_vanished

export var _points: int


func destroy():
	emit_signal("collectible_vanished")
	queue_free()


func collect() -> int:
	emit_signal("collectible_vanished")
	queue_free()
	return _points
