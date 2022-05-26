extends Node


export var _default_background_music: AudioStream


func _ready():
	if _default_background_music != null:
		change_background_music(_default_background_music)


func change_background_music(stream: AudioStream):
	if stream != null:
		$Background.stream = stream
		$Background.play()


func change_volume(bus: String, volume: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), _float_to_decibel(volume))


func mute_bus(bus: String):
	AudioServer.set_bus_mute(AudioServer.get_bus_index(bus), true)


func unmute_bus(bus: String):
	AudioServer.set_bus_mute(AudioServer.get_bus_index(bus), false)


func _float_to_decibel(value: float) -> float:
	return 20 * _log_10(value)


func _log_10(value: float) -> float:
	return log(value)/log(10)
