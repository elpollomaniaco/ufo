extends RigidBody

signal health_changed
signal energy_changed

export var _max_health: float = 100
export var acceleration: int = 2000
# Make tractor beam toggle
export var toggle_tractor_beam: bool = false
export var max_energy: float = 100.0
export var energy_regeneration: float = 1.0

var _current_health: float
var _current_energy: float
var _score: int = 0


func _ready():
	_deactivate_tractor_beam()
	_current_energy = max_energy
	_current_health = _max_health


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
		emit_signal("energy_changed", _current_energy)


func try_to_drain_energy(amount: float) -> bool:
	if _current_energy > amount:
		_current_energy -= amount
		emit_signal("energy_changed", _current_energy)
		return true
	else:
		return false


func add_points_to_score(points: int):
	_score += points


func get_ground_position() -> Vector3:
	return Vector3(translation.x, 0, translation.z)


func take_damage(damage):
	_current_health -= damage
	emit_signal("health_changed", _current_health)
	if _current_health < 0:
		_die()


func _die():
	queue_free()
