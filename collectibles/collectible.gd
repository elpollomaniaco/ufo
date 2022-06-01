extends RigidBody


signal collectible_vanished

export var _points: int
export var _energy_charge: float
export var _attract_sounds: Array # Type: AudioStream
export var _dying_sounds: Array # Type: AudioStream


func destroy():
	emit_signal("collectible_vanished")
	_play_random_dying_sound()
	queue_free()


func collect() -> Dictionary:
	emit_signal("collectible_vanished")
	queue_free()
	
	var collection = {
		"Points": _points,
		"Energy": _energy_charge
	}
	return collection


func attract():
	if _attract_sounds.size() > 0 and not $SFX.playing:
		var idx = randi() % _attract_sounds.size()
		$SFX.stream = _attract_sounds[idx]
		$SFX.play()


func _play_random_dying_sound():
	if _dying_sounds.size() > 0:
		var idx = randi() % _dying_sounds.size()
		AudioController.play_sound_effect(_dying_sounds[idx], "Collectibles")
