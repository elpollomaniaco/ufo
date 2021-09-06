extends Area


func _on_Hatch_body_entered(body):
	_collect_collectible(body)


func _collect_collectible(collectible):
	get_owner().add_points_to_score(collectible.points)
	collectible.queue_free()
