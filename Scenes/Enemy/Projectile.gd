extends RigidBody

export var _damage: float = 13.0


func _on_LiveTimer_timeout():
	queue_free()


func _on_Trigger_body_entered(body):
	body.take_damage(_damage)
	queue_free()
