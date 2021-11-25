extends Control


var _current_focus: int = -1

onready var _energy_containers: Array = get_children()
onready var _energy_per_container: float = 100.0 / _energy_containers.size()
# Container is rotated by 90 degrees so y equals width.s
onready var _container_width: int = _energy_containers[0].rect_size.y
onready var _container_spacing: int = (_energy_containers[1].rect_position.x
		- _energy_containers[0].rect_position.x 
		- _container_width)
onready var _focus_scale: float = _energy_containers[-1].rect_scale.x


func _ready():
	_init_containers()


func change_value(new_value: float):
	var container_number: int = (new_value / _energy_per_container) as int
	var container_value: float = fmod(new_value, _energy_per_container)
	_change_container_value(container_number, container_value)


func _change_container_value(container_number: int, new_value: float):
	if container_number < _energy_containers.size():
		_energy_containers[container_number].value = new_value
		_focus_container(container_number)
		
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
	_focus_container(_energy_containers.size() - 1)


func _focus_container(container_number: int):
	if container_number != _current_focus:
		# First position is not 0 because of rotation and pivot.
		var h_position = -_container_width
		var index = 0
		for container in _energy_containers:
			container.rect_position.x = h_position
			
			if index == container_number:
				container.rect_scale = Vector2(_focus_scale, _focus_scale)
			else:
				container.rect_scale = Vector2(1.0, 1.0)
			
			index += 1
			h_position += container.rect_scale.y * _container_width + _container_spacing
		_current_focus = container_number
