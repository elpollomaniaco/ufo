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
	_game_over(false)


func _on_Player_last_collectible_collected():
	_game_over(true)


func _game_over(successful: bool):
	var collectible_score = $Player.get_score()
	var time_score = 0
	var health_score = 0
	
	if successful:
		time_score = max(600 - $PlayTimer.get_elapsed_time(), 0)
		health_score = max($Player.get_health() as int, 0)
	
	var total_score = collectible_score + time_score + health_score
	
	$GameOver.show()
	$GameOver.set_outcome(successful, total_score, collectible_score, time_score, health_score)
	get_tree().paused = true
