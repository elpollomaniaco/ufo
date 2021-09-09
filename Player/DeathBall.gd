extends KinematicBody

var _speed = 10


func _physics_process(delta):
	move_and_slide(Vector3.DOWN * _speed)


func _on_Trigger_body_entered(body):
	body.queue_free()
