extends RigidBody


export var _movement_acceleration: int
export var _attack_range: int
export var _fire_power: int
export var _projectile_scene: PackedScene

# Player node will be set during initilization.
# Initializing script (Level) can access player node easier (no search for root).
var _player_node
var _is_reloading: bool = false

# Avoiding sqrt.
onready var _moving_threshold_distance: int = pow(_attack_range, 2)


func initialize(starting_position, player_node):
	translation = starting_position
	_player_node = player_node


# In _integrate_forces so add_force and look_at will work together.
func _integrate_forces(_state):
	# Validity check to prevent error when calling queue_free() on player.
	if is_instance_valid(_player_node):
		var target_position = _player_node.get_ground_position()
		
		if transform.origin.distance_squared_to(target_position) > _moving_threshold_distance:
			_follow_player(target_position)
		else:
			_attack_player(_player_node.translation)
			
		# Make enemy turn on UP-axis only.
		look_at(Vector3(target_position.x, translation.y, target_position.z), Vector3.UP)


func destroy():
	queue_free()


func _follow_player(ground_position: Vector3):
	var direction = ground_position - transform.origin
	direction = direction.normalized()
	add_central_force(direction * _movement_acceleration)


func _attack_player(player_position: Vector3):
	if not _is_reloading:
		_fire_projectile(player_position)
		$AttackTimer.start()
		
		_is_reloading = true
		yield($AttackTimer, "timeout")
		_is_reloading = false


func _fire_projectile(target_position: Vector3):
	var direction = target_position - transform.origin
	direction = direction.normalized()
	
	var projectile: RigidBody = _projectile_scene.instance()
	# Add instance to level so it won't be moved with enemy.
	get_tree().get_root().get_node("Level").add_child(projectile)
	
	# Move, turn and fire projectile.
	projectile.translation = ($ProjectileOffset as Spatial).global_transform.origin
	projectile.look_at(target_position, Vector3.UP)
	projectile.apply_central_impulse(direction * _fire_power)
