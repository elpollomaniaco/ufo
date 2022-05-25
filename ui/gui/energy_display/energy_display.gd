extends Control


# Attention: both not yet secured against changes in player node!
const MAX_ENERGY = 100.0
const INDICATOR_ENERGY = 20.0 # Weapon energy usage

export var _tween_time: float

var _shown_value: float = 0.0

onready var _indicators: Array = $Indicators.get_children()
onready var _energy_container: TextureProgress = $Vial
onready var _tween: Tween = $Tween


func _ready():
	_init_display()
	change_value(MAX_ENERGY)


func _process(_delta):
	_energy_container.value = _shown_value


func change_value(new_value: float):
	# Change shown value
	# warning-ignore:return_value_discarded
	_tween.interpolate_property(self, "_shown_value", null, new_value, _tween_time)
	if not _tween.is_active():
		# warning-ignore:return_value_discarded
		_tween.start()
		
	# Change indicator state
	for idx in _indicators.size():
		var indicator = _indicators[idx]
		if new_value >= ((idx + 1) * INDICATOR_ENERGY):
			indicator.activate()
		else:
			indicator.deactivate()


func _init_display():
	for indicator in _indicators:
		indicator.activate()
