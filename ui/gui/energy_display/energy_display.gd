extends Control


# Not yet secured against changes in player node!
const MAX_ENERGY = 100.0

onready var _reserve_containers: Array = $ReserveContainers.get_children()
# x + 1 because main container is also filled.
onready var _energy_in_container = MAX_ENERGY / (_reserve_containers.size() + 1)


func _ready():
	_init_containers()


func change_value(new_value: float):
	var container_number: int = (new_value / _energy_in_container) as int
	var container_value: float = fmod(new_value, _energy_in_container)
	_change_container_value(container_number + 1, container_value)


func _change_container_value(container_number: int, new_value: float):
	if container_number <= (_reserve_containers.size() + 1):
		$EnergyContainer.value = new_value
		if container_number <= _reserve_containers.size():
			# Access backwars because of automatic order of controls.
			_reserve_containers[-container_number].deactivate()
		
		# Reactivating successor important when regeneration fills container.
		# Successor means reserve container which would be emptied next.
		var successor_container_number: int = container_number - 1
		if successor_container_number > 0 and successor_container_number <= _reserve_containers.size():
			_reserve_containers[-successor_container_number].activate()

func _init_containers():
	$EnergyContainer.max_value = _energy_in_container
	$EnergyContainer.value = _energy_in_container
	for reserve_container in _reserve_containers:
		reserve_container.activate()
