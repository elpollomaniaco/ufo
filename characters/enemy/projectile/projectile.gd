extends RigidBody


export var _damage: float


func _on_LiveTimer_timeout():
	queue_free()


func _on_Trigger_body_entered(body):
	body.damage(_damage)
	queue_free()
