extends RigidBody

export var _acceleration: int = 500
export var _attack_range: int = 10

var _player_node
var _moving_threshold_distance: int


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


func _follow_player(player_position):
	var direction = player_position - transform.origin
	direction = direction.normalized()
	add_central_force(direction * _acceleration)
