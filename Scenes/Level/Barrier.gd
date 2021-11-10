extends Area


const PUSH_FORCE: int = 4000

export var _push_direction: Vector3

# Only one player in game. No need to search every time force is added.
# Owner = Level.
onready var _player_node: RigidBody = owner.get_node("Player") 

var _player_is_in_area: bool = false


func _physics_process(delta):
	if _player_is_in_area:
		_add_force_to_player()


func _add_force_to_player():
	if is_instance_valid(_player_node):
		_player_node.add_central_force(_push_direction * PUSH_FORCE)


# Collision detection only with player layer.
func _on_Barrier_body_entered(body):
	_player_is_in_area = true


func _on_Barrier_body_exited(body):
	_player_is_in_area = false
