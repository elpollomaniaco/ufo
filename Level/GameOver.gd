extends Control

var _input_is_deactivated: bool = true

func _process(delta):
	if not _input_is_deactivated:
		if Input.is_action_just_pressed("player_tractor_beam"):
			get_tree().change_scene("res://MainMenu/MainMenu.tscn")
			get_tree().paused = false


func set_outcome(successful: bool, total_score: int, collectible_score: int, time_score: int, health_score):
	if successful:
		$Title.text = "You did it!"
	
	$Scores/CollectibleScore/Value.text = str(collectible_score)
	$Scores/TimeScore/Value.text = str(time_score)
	$Scores/HealthScore/Value.text = str(health_score)
	$Scores/TotalScore/Value.text = str(total_score)
	
	$InputTimeout.start()


func _on_InputTimeout_timeout():
	_input_is_deactivated = false
	$Return.show()
