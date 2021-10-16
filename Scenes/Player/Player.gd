extends RigidBody

signal health_changed
signal energy_changed
signal score_changed
signal player_died
signal last_collectible_collected

export var _max_health: float = 100
export var acceleration: int = 2000
# Make tractor beam toggle
export var toggle_tractor_beam: bool = false
export var max_energy: float = 100.0
export var energy_regeneration: float = 1.0
export var _attack_porjectile_scene: PackedScene
export var _attack_energy_usage: float = 10.0

var _current_health: float
var _current_energy: float
var _score: int = 0
var _animationPlayer: AnimationPlayer
var _attackAnimation: String = "UFOEarsAttack"
var _beamAnimation: String = "UFOEarsBeam"
var _ground_position: Vector3

func _ready():
	_current_energy = max_energy
	_current_health = _max_health
	_animationPlayer = $Pivot/UFO/SecondaryAnimationPlayer
	_deactivate_tractor_beam()


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
	
	if Input.is_action_just_pressed("player_attack") and try_to_drain_energy(_attack_energy_usage):
		_attack()

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
	_animationPlayer.play(_beamAnimation)


func _deactivate_tractor_beam():
	$TractorBeam.hide()
	$TractorBeam.set_physics_process(false)
	_animationPlayer.stop()


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
	emit_signal("score_changed", _score)


func get_ground_position() -> Vector3:
	return _ground_position


func take_damage(damage):
	_current_health -= damage
	emit_signal("health_changed", _current_health)
	if _current_health <= 0:
		_die()


func _die():
	# Reparent camera so it won't be freed with player
	var camera = $CameraArm
	var old_position = camera.global_transform.origin
	var old_parent = self
	var new_parent = get_tree().get_root().get_node("Level")
	old_parent.remove_child(camera)
	new_parent.add_child(camera)
	camera.set_owner(new_parent)
	camera.translation = old_position
	
	emit_signal("player_died")
	queue_free()


func get_score() -> int:
	return _score


func get_health() -> float:
	return _current_health


func _attack():
	var projectile = _attack_porjectile_scene.instance()
	get_tree().get_root().get_node("Level").add_child(projectile)
	projectile.translation = transform.origin
	_animationPlayer.play(_attackAnimation)


# Using RayCast to take level height into account.
# Called by timer to improve performance. Calling get_collision_point() every frame was unplayable on laptop.
# Updating the position every second for enemies to follow the player is enough, as throwing projectiles is calculated completely independently.
func _update_ground_position():
	if $AimMarker.is_colliding():
		_ground_position = $AimMarker.get_collision_point()
