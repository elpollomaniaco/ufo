extends Area


func _on_Hatch_body_entered(body):
	_collect_collectible(body)


func _collect_collectible(collectible):
	get_owner().add_points_to_score(collectible.points)
	collectible.queue_free()
	# Collectible won't be freed until after frame. So having size == 1 means last collectible was just collected
	if get_tree().get_nodes_in_group("Collectibles").size() <= 1:
		# Emiting via owner so it's easier to connect in Level
		get_owner().emit_signal("last_collectible_collected")
