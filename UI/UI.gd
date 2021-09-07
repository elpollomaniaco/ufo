extends Control


func _on_Player_health_changed(new_value):
	$Health.value = new_value


func _on_Player_energy_changed(new_value):
	$Energy.value = new_value
