extends RigidBody


signal health_changed
signal energy_changed
signal score_changed
signal player_died

const MAX_HEALTH: int = 100
const MAX_ENERGY: float = 100.0
const ATTACK_ANIMATION_NAME: String = "UFOEarsAttack"
const BEAM_ANIMATION_NAME: String = "UFOEarsBeam"

export var _movement_acceleration: int
export var _energy_regeneration: float
export var _damage_sounds: Array # Type: AudioStream

var _current_health: int = MAX_HEALTH
var _current_energy: float = MAX_ENERGY
var _score: int = 0
var _ground_position: Vector3
# Pressing button/key toggles beam.
# No need to hold down.
var _does_tractor_beam_toggle: bool = false

onready var _animation_player: AnimationPlayer = $Pivot/UFO/SecondaryAnimationPlayer


func _ready():
	_deactivate_tractor_beam()


func _physics_process(_delta):
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
		add_central_force(direction * _movement_acceleration)


func _process(delta):
	_control_tractor_beam()
	_regenerate_energy(delta)
	
	if Input.is_action_just_pressed("player_attack"):
		_attack()


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


func damage(amount: int):
	if _current_health > 0: # Not dead yet/already dying
		_current_health -= amount
		emit_signal("health_changed", _current_health)
		_play_random_damage_sound()
		if _current_health <= 0:
			_die()


func recharge_energy(amount: float):
	if amount > 0:
		_current_energy = min(_current_energy + amount, MAX_ENERGY)
		emit_signal("energy_changed", _current_energy)


func get_score() -> int:
	return _score


func get_health() -> int:
	return _current_health


func _control_tractor_beam():
	if _does_tractor_beam_toggle:
		if Input.is_action_just_pressed("player_tractor_beam"):
			_toggle_tractor_beam()
	else:
		if Input.is_action_just_pressed("player_tractor_beam"):
			_activate_tractor_beam()
		if Input.is_action_just_released("player_tractor_beam"):
			_deactivate_tractor_beam()


func _activate_tractor_beam():
	$TractorBeam.activate()
	_animation_player.play(BEAM_ANIMATION_NAME)


func _deactivate_tractor_beam():
	$TractorBeam.deactivate()
	_animation_player.stop()


func _toggle_tractor_beam():
	if $TractorBeam.visible:
		_deactivate_tractor_beam()
	else:
		_activate_tractor_beam()


func _regenerate_energy(delta: float):
	# Don't waste this one or two cycles if energy is already fully loaded.
	if _current_energy < MAX_ENERGY:
		_current_energy = min(_current_energy + (_energy_regeneration * delta), MAX_ENERGY)
		emit_signal("energy_changed", _current_energy)


func _die():
	# Reparent camera so it won't be freed with player.
	var camera = $CameraArm
	var old_position = camera.global_transform.origin
	var old_parent = self
	var new_parent = owner
	old_parent.remove_child(camera)
	new_parent.add_child(camera)
	camera.set_owner(new_parent)
	camera.translation = old_position
	
	emit_signal("player_died")
	queue_free()


func _attack():
	if $Weapon.attack():
		_animation_player.play(ATTACK_ANIMATION_NAME)


# Using RayCast to take level height into account.
# Called by timer to improve performance. 
# Calling get_collision_point() every frame was unplayable on laptop.
# Updating the position every second for enemies to follow the player is enough, 
# as throwing projectiles is calculated completely independently.
func _update_ground_position():
	if $AimMarker.is_colliding():
		_ground_position = $AimMarker.get_collision_point()


func _play_random_damage_sound():
	var idx = randi() % _damage_sounds.size()
	var stream_player = AudioStreamPlayer.new()
	stream_player.stream = _damage_sounds[idx]
	stream_player.bus = "UFO"
	
	$SFX.add_child(stream_player)
	stream_player.play()
	
	# Won't be freed automatically
	yield(stream_player, "finished") 
	stream_player.queue_free()
