extends RigidBody

export var _acceleration: int = 500
export var _attack_range: int = 10
export var _projectile: PackedScene
export var _fire_power: int = 25000

var _player_node
var _moving_threshold_distance: int
var _is_reloading: bool = false


func _ready():
	# For making faster distance comparisons and avoiding sqrt
	_moving_threshold_distance = pow(_attack_range, 2)


func initialize(starting_position, player_node):
	translation = starting_position
	_player_node = player_node


# In _integrate_forces so add_force and look_at will work together
func _integrate_forces(state):
	# Validity check to prevent error when calling queue_free() on player
	if is_instance_valid(_player_node):
		var target_position = _player_node.get_ground_position()
		if transform.origin.distance_squared_to(target_position) > _moving_threshold_distance:
			_follow_player(target_position)
		else:
			_attack_player(_player_node.translation)
		look_at(target_position, Vector3.UP)


func _follow_player(player_position):
	var direction = player_position - transform.origin
	direction = direction.normalized()
	add_central_force(direction * _acceleration)


func _attack_player(player_position):
	if not _is_reloading:
		_fire_projectile(player_position)
		$AttackTimer.start()
		_is_reloading = true
		yield($AttackTimer, "timeout")
		_is_reloading = false


func _fire_projectile(player_position):
	var direction = player_position - transform.origin
	direction = direction.normalized()
	
	var projectile = _projectile.instance()
	get_tree().get_root().get_node("Level").add_child(projectile)
	
	projectile.translation = translation
	projectile.add_central_force(direction * _fire_power)
