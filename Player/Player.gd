extends RigidBody


export var acceleration: int = 2000
# Make tractor beam toggle
export var toggle_tractor_beam: bool = false
export var max_energy: float = 100.0
export var energy_regeneration: float = 1.0

var _current_energy: float


func _ready():
	_deactivate_tractor_beam()
	_current_energy = max_energy


func _physics_process(delta):
	var direction: Vector3 = Vector3.ZERO
	
	if Input.is_action_pressed("player_move_left"):
		direction.x -= 1
	if Input.is_action_pressed("player_move_right"):
		direction.x += 1
	if Input.is_action_pressed("player_move_up"):
		direction.z -= 1
	if Input.is_action_pressed("player_move_down"):
		direction.z += 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		add_central_force(direction * acceleration)


func _process(delta):
	_control_tractor_beam()
	_regenerate_energy(delta)

func _control_tractor_beam():
	if toggle_tractor_beam:
		if Input.is_action_just_pressed("player_tractor_beam"):
			_toggle_tractor_beam()
	else:
		if Input.is_action_just_pressed("player_tractor_beam"):
			_activate_tractor_beam()
		if Input.is_action_just_released("player_tractor_beam"):
			_deactivate_tractor_beam()


func _activate_tractor_beam():
	$TractorBeam.show()
	$TractorBeam.set_physics_process(true)


func _deactivate_tractor_beam():
	$TractorBeam.hide()
	$TractorBeam.set_physics_process(false)


func _toggle_tractor_beam():
	if $TractorBeam.visible:
		_deactivate_tractor_beam()
	else:
		_activate_tractor_beam()


func _regenerate_energy(delta):
	# Don't waste this one or two cycles if energy is already fully loaded
	if _current_energy < max_energy:
		_current_energy = min(_current_energy + (energy_regeneration * delta), max_energy)


func try_to_drain_energy(amount) -> bool:
	if _current_energy > amount:
		_current_energy -= amount
		return true
	else:
		return false
