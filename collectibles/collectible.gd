extends RigidBody


export var _points: int


func destroy():
	queue_free()


func collect() -> int:
	queue_free()
	return _points
