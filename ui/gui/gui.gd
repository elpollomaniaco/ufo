extends Control


func _on_Player_health_changed(new_value: int):
	$HealthDisplay.change_value(new_value)


func _on_Player_energy_changed(new_value: float):
	$EnergyDisplay.change_value(new_value)


func _on_Player_score_changed(new_value: int):
	$ScoreDisplay.change_value(new_value)


func _on_PlayTimer_play_time_changed(new_value: int):
	$TimeDisplay.change_value(new_value)
