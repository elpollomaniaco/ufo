extends Control


# Not yet secured against changes in player node!
const MAX_ENERGY = 100.0

onready var _reserve_indicators: Array = $Reserve.get_children()
onready var _energy_container: TextureProgress = $Vial
# x + 1 because main container is also filled.
onready var _energy_in_container: float = MAX_ENERGY / (_reserve_indicators.size() + 1)


func _ready():
	_init_display()


func change_value(new_value: float):
	var container_number: int = (new_value / _energy_in_container) as int
	var container_value: float = fmod(new_value, _energy_in_container)
	_change_container_value(container_number, container_value)


func _change_container_value(container_number: int, new_value: float):
	# Prevent container to appear empty when energy is at max.
	# mod -> 0.
	if container_number <= _reserve_indicators.size():
		_energy_container.value = new_value
		if container_number < _reserve_indicators.size():
			_reserve_indicators[container_number].deactivate()
		
		# Reactivating successor important when regeneration fills container.
		# Successor means reserve container which would be emptied next.
		var successor_container_number: int = container_number - 1
		if successor_container_number >= 0:
			_reserve_indicators[successor_container_number].activate()

func _init_display():
	_energy_container.max_value = _energy_in_container
	_energy_container.value = _energy_in_container
	for reserve_indicator in _reserve_indicators:
		reserve_indicator.activate()
