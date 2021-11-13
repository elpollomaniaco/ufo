extends Area


func _on_Hatch_body_entered(body):
	if body.has_method("collect"):
		_collect(body)
	elif body.has_method("destroy"):
		body.destroy()
	else:
		body.queue_free()


func _collect(collectible):
	var points = collectible.collect()
	owner.add_points_to_score(points)
