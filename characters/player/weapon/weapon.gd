extends Spatial


export var _energy_usage: float


# -> Relay check if there is enough energy left for usage.
func attack() -> bool:
	if owner.try_to_drain_energy(_energy_usage):
		$Claws.start_extension()
		return true
	else:
		return false


func get_target() -> Vector3:
	return get_owner().get_ground_position()
