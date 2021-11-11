extends Control


func _on_Player_health_changed(new_value: int):
	$Health.value = new_value


func _on_Player_energy_changed(new_value: float):
	$Energy.value = new_value


func _on_Player_score_changed(new_value: int):
	$Score/Value.text = str(new_value)


func _on_PlayTimer_play_time_changed(new_value: int):
	# warning-ignore:integer_division
	$Time/Value.text = "%02d:%02d" % [new_value / 60, new_value % 60]
