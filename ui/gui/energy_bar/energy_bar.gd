extends Control


onready var _energy_containers: Array = get_children()
onready var _energy_per_container: float = 100.0 / _energy_containers.size()


func _ready():
	_init_containers()


func change_value(new_value: float):
	var container_number: int = (new_value / _energy_per_container) as int
	var container_value: float = fmod(new_value, _energy_per_container)
	_change_container_value(container_number, container_value)


func _change_container_value(container_number: int, new_value: float):
	if container_number < _energy_containers.size():
		_energy_containers[container_number].value = new_value
		
		# Change value of neighbouring containers.
		var left_container = container_number - 1
		if left_container >= 0:
			_energy_containers[left_container].value = _energy_containers[left_container].max_value
		
		var right_container = container_number + 1
		if right_container < _energy_containers.size():
			_energy_containers[right_container].value = 0.0
	else:
		# Set last container to be full.
		_energy_containers[-1].value = _energy_containers[-1].max_value


func _init_containers():
	for energy_container in _energy_containers:
		energy_container.max_value = _energy_per_container
		energy_container.value = _energy_per_container
