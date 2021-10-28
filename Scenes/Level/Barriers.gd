extends Area


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
		var direction: Vector3
		# Make direction face towards centre
		direction = Vector3(_player_node.translation.x, 0.0, _player_node.translation.z)
		direction = -1 * direction.normalized() 
		_player_node.add_central_force(direction * _force)


func _on_Barriers_body_entered(body):
	_player_is_in_area = true


func _on_Barriers_body_exited(body):
	_player_is_in_area = false
