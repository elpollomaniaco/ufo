extends Node

export var _enemy_scene: PackedScene

var _spawn_points: Array


func _ready():
	randomize()
	_spawn_points = get_tree().get_nodes_in_group("EnemySpawnPoints")


func _on_SpawnTimer_timeout():
	var random_index = randi() % _spawn_points.size()
	var start_position = _spawn_points[random_index].transform.origin
	
	var enemy = _enemy_scene.instance()
	var player_node = $Player
	
	if is_instance_valid(player_node):
		add_child(enemy)
		enemy.initialize(start_position, $Player)
