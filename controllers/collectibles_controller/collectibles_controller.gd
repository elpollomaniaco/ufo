extends Node


signal last_collectible_vanished

const GROUP_NAME = "Collectibles"


func _ready():
	for collectible in get_tree().get_nodes_in_group(GROUP_NAME):
		collectible.connect("collectible_vanished", self, "_on_collectible_vanished")


func _on_collectible_vanished():
	# Collectible won't be freed until after frame. So having size == 1 means last collectible was just collected/destroyed.
	if get_tree().get_nodes_in_group(GROUP_NAME).size() <= 1:
		emit_signal("last_collectible_vanished")
