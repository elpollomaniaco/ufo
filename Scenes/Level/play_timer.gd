extends Timer


signal play_time_changed

var _play_time: int = 0


func get_elapsed_time() -> int:
	return _play_time


func _on_PlayTimer_timeout():
	_play_time += 1
	emit_signal("play_time_changed", _play_time)
