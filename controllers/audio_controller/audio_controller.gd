extends Node


export var _default_background_music: AudioStream


func _ready():
	if _default_background_music != null:
		change_background_music(_default_background_music)


func change_background_music(stream: AudioStream):
	if stream != null:
		$Background.stream = stream
		$Background.play()
