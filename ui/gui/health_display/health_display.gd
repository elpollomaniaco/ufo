extends Control


# Not yet secured against changes in player node!
const MAX_HEALTH: int = 100

export var _tween_time: float

var _shown_value: float = 0.0

onready var _progress: TextureProgress = $Vial
onready var _tween: Tween = $Tween


func _ready():
	change_value(MAX_HEALTH)


func _process(_delta):
	_progress.value = _shown_value


func change_value(new_value: int):
	_change_progress_bar_value(new_value)


func _change_progress_bar_value(new_value: int):
	# warning-ignore:return_value_discarded
	_tween.interpolate_property(self, "_shown_value", null, new_value, _tween_time)
	if not _tween.is_active():
		# warning-ignore:return_value_discarded
		_tween.start()
