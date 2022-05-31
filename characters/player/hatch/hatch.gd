extends Area


func _on_Hatch_body_entered(body):
	if body.has_method("collect"):
		_collect(body.collect())
	elif body.has_method("destroy"):
		body.destroy()
	else:
		body.queue_free()
	$SFX.play()


func _collect(collection: Dictionary):
	var points = collection["Points"]
	var energy = collection["Energy"]
	
	if points > 0:
		owner.add_points_to_score(points)
	
	if energy > 0:
		owner.recharge_energy(energy)
