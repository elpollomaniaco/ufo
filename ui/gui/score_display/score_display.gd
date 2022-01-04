extends Control


export var _min_step: int

var _score: int = 0

# Score shown in this frame.
onready var _shown_score: float = _score


func _process(delta):
	if _shown_score < _score:
		var difference = (_score - _shown_score)
		# Limit the value downwards so that growth does not become infinitely slow.
		# Take that, Zeno!
		var step = max(difference, _min_step) * delta
		# Because of _min_step shown score could become higher than actual score.
		_shown_score = min(_shown_score + step, _score)
		_show_value(_shown_score)


func change_value(new_value: int):
	_score = new_value


func _show_value(new_value: float):
	# float is needed for calculation during _process().
	var value = "%04d" % new_value
	$Value.text = value
