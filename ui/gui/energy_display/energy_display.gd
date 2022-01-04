extends Control


# Not yet secured against changes in player node!
const MAX_ENERGY = 100.0

export var _tween_time: float

var _shown_value: float = 0.0

onready var _reserve_indicators: Array = $Reserve.get_children()
onready var _energy_container: TextureProgress = $Vial
# x + 1 because main container is also filled.
onready var _energy_in_container: float = MAX_ENERGY / (_reserve_indicators.size() + 1)
onready var _tween: Tween = $Tween


func _ready():
	_init_display()
	change_value(MAX_ENERGY)


func _process(_delta):
	_energy_container.value = _shown_value


func change_value(new_value: float):
	var container_number: int = (new_value / _energy_in_container) as int
	var container_value: float = fmod(new_value, _energy_in_container)
	_change_container_value(container_number, container_value)


func _change_container_value(container_number: int, new_value: float):
	# Prevent container to appear empty when energy is at max.
	# mod -> 0.
	if container_number > _reserve_indicators.size():
		new_value = _energy_in_container
	
	# warning-ignore:return_value_discarded
	_tween.interpolate_property(self, "_shown_value", null, new_value, _tween_time)
	if not _tween.is_active():
		# warning-ignore:return_value_discarded
		_tween.start()
	
	if container_number < _reserve_indicators.size():
		_reserve_indicators[container_number].deactivate()
	
	# Reactivating successor important when regeneration fills container.
	# Successor means reserve container which would be emptied next.
	var successor_container_number: int = container_number - 1
	if successor_container_number >= 0 and successor_container_number < _reserve_indicators.size():
		_reserve_indicators[successor_container_number].activate()


func _init_display():
	_energy_container.max_value = _energy_in_container
	for reserve_indicator in _reserve_indicators:
		reserve_indicator.activate()
