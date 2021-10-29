extends Area


export var _direction: Vector3
export var _force = 4000
var _player_node: RigidBody
var _player_is_in_area: bool = false

func _ready():
	# Reduce search queries for player node
	_player_node = get_tree().get_root().get_node("Level/Player")


func _physics_process(delta):
	if _player_is_in_area:
		_add_force_to_player()


func _add_force_to_player():
	if is_instance_valid(_player_node):
		_player_node.add_central_force(_direction * _force)


# Collision detection only with player layer
func _on_Barrier_body_entered(body):
	_player_is_in_area = true


func _on_Barrier_body_exited(body):
	_player_is_in_area = false
