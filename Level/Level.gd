extends Node

export var _enemy_scene: PackedScene

var _spawn_points: Array


func _ready():
	randomize()
	_spawn_points = get_tree().get_nodes_in_group("EnemySpawnPoints")


func _process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		_pause_game()


func _on_SpawnTimer_timeout():
	var random_index = randi() % _spawn_points.size()
	var start_position = _spawn_points[random_index].transform.origin
	
	var enemy = _enemy_scene.instance()
	var player_node = $Player
	
	if is_instance_valid(player_node):
		add_child(enemy)
		enemy.initialize(start_position, $Player)


func _pause_game():
	$PauseMenu.show()
	$PauseMenu.set_process(true)
	$PauseMenu/Buttons/Resume.grab_focus()
	get_tree().paused = true


func _on_Player_player_died():
	_game_over()


func _on_Player_last_collectible_collected():
	_game_over()


func _game_over():
	$GameOver.show()
	$GameOver.set_outcome($Player.get_score())
	get_tree().paused = true
