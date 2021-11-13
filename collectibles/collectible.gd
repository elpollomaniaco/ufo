extends RigidBody


export var _points: int

onready var _collectibles_controller = get_tree().get_root().get_node("Level/CollectiblesController")


func destroy():
	_collectibles_controller.collectible_vanished()
	queue_free()


func collect() -> int:
	_collectibles_controller.collectible_vanished()
	queue_free()
	return _points
