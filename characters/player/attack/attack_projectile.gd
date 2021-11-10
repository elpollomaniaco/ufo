extends KinematicBody


const SPEED = 100


func _physics_process(_delta):
	move_and_slide(Vector3.DOWN * SPEED)


func _on_Trigger_body_entered(body):
	body.queue_free()


func _on_DissolveTimer_timeout():
	queue_free()
