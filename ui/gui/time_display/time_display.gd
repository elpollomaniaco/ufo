extends Control


func change_value(new_value: int):
	# Integer devision is intended. Shows minutes.
	# warning-ignore:integer_division
	$Value.text = "%02d:%02d" % [new_value / 60, new_value % 60]
