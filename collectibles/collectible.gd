extends RigidBody


export var points: int


func destroy():
	queue_free()
