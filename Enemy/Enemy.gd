extends RigidBody

export var _acceleration: int = 500
export var _attack_range: int = 10
export var _projectile: PackedScene
export var _fire_power: int = 20000

var _player_node
var _moving_threshold_distance: int
var _is_reloading: bool = false


func _ready():
	var start = Vector3(0,0,0)
	initialize(start, get_owner().get_node("Player"))
	# For making faster distance comparisons and avoiding sqrt
	_moving_threshold_distance = pow(_attack_range, 2)


func initialize(starting_position, player_node):
	translation = starting_position
	_player_node = player_node


func _physics_process(delta):
	var target_position = _player_node.get_ground_position()
	if transform.origin.distance_squared_to(target_position) > _moving_threshold_distance:
		_follow_player(target_position)
	else:
		_attack_player(_player_node.translation)


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
	owner.add_child(projectile)
	
	projectile.translation = translation
	projectile.add_central_force(direction * _fire_power)
