extends Control


export var _main_menu_scene: PackedScene

var _input_is_deactivated: bool = true


func _process(_delta):
	if not _input_is_deactivated:
		if Input.is_action_just_pressed("player_tractor_beam"):
			get_tree().change_scene_to(_main_menu_scene)
			get_tree().paused = false


func show_score(successful: bool, total_score: int, collectible_score: int, time_score: int, health_score: int):
	if successful:
		$Background/Success.show()
	else:
		$Background/Failed.show()
	
	self.show()
	
	var collectibles = $ScoreBackground/Scores/CollectibleScore
	var time = $ScoreBackground/Scores/TimeScore
	var health = $ScoreBackground/Scores/HealthScore
	var total = $ScoreBackground/Scores/TotalScore
	
	collectibles.set_score(collectible_score)
	yield(collectibles, "count_up_finished")
	time.set_score(time_score)
	yield(time, "count_up_finished")
	health.set_score(health_score)
	yield(health, "count_up_finished")
	total.set_score(total_score)
	yield(total, "count_up_finished")
	
	$InputTimeout.start()


func _on_InputTimeout_timeout():
	_input_is_deactivated = false
	$ScoreBackground/Return/AnimationPlayer.play("flash")
