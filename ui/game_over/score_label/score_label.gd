extends Control


signal count_up_finished

export var _label_text: String = "Score"
export var _bold: bool = false

var _tween_time: float = 2
var _shown_value: float = 0.0

onready var _tween: Tween = $Tween


func _ready():
	$Label.text = _label_text
	
	if _bold:
		var bold_theme = load("res://ui/shared/themes/big_bold_theme.tres")
		$Label.set_theme(bold_theme)
		$Value.set_theme(bold_theme)
	
	self.set_process(false)


func _process(_delta):
	$Value.text = "%d" % _shown_value 


func set_score(value: float):
	if not self.is_processing():
		self.set_process(true)
	
	if value == _shown_value:
		yield(get_tree(), "idle_frame") # Wait so menu can connect to signal.
		_on_tween_completed()
		return
	
	# warning-ignore:return_value_discarded
	_tween.interpolate_property(self, "_shown_value", null, value, _tween_time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	if not _tween.is_active():
		# warning-ignore:return_value_discarded
		_tween.start()
		# warning-ignore:return_value_discarded
		_tween.connect("tween_all_completed", self, "_on_tween_completed")


func _on_tween_completed():
	emit_signal("count_up_finished")
