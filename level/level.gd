extends Node


const MAX_TIME_SCORE: int = 600

export var _background_music: AudioStream
export var _enemy_scene: PackedScene

onready var _spawn_points: Array = get_tree().get_nodes_in_group("EnemySpawnPoints")


func _ready():
	randomize()
	_set_background_music()


func _process(_delta):
	if Input.is_action_just_pressed("ui_pause"):
		_pause_game()


func _on_SpawnTimer_timeout():
	var random_index = randi() % _spawn_points.size()
	var start_position = _spawn_points[random_index].transform.origin
	
	var enemy = _enemy_scene.instance()
	var player_node = $Player
	
	if is_instance_valid(player_node):
		add_child(enemy)
		enemy.initialize(start_position, player_node)


func _pause_game():
	$PauseMenu.show_pause_menu()
	get_tree().paused = true


func _on_Player_player_died():
	_game_over(false)


func _on_CollectiblesController_last_main_collectible_vanished():
	_game_over(true)


func _game_over(successful: bool):
	var collectible_score = $Player.get_score()
	var time_score = 0
	var health_score = 0
	
	if successful:
		time_score = max(MAX_TIME_SCORE - $PlayTimer.get_elapsed_time(), 0)
		health_score = max($Player.get_health(), 0)
	
	var total_score = collectible_score + time_score + health_score
	
	$GameOver.show_score(successful, total_score, collectible_score, time_score, health_score)
	get_tree().paused = true


func _set_background_music():
	AudioController.change_background_music(_background_music)
