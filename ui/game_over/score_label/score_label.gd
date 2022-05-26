extends Control


signal count_up_finished

export var _label_text: String = "Score"

var _tween_time: float = 2
var _shown_value: float = 0.0

onready var _tween: Tween = $Tween


func _ready():
	$Label.text = _label_text
	self.set_process(false)


func _process(delta):
	$Value.text = "%d" % _shown_value 


func set_score(value: float):
	_tween.interpolate_property(self, "_shown_value", null, value, _tween_time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	if not _tween.is_active():
		# warning-ignore:return_value_discarded
		_tween.start()
		self.set_process(true)
