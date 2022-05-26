extends Node


export var _background_music: AudioStream


func _ready():
	if _background_music != null:
		change_background_music(_background_music)
		$Background.play()


func change_background_music(stream: AudioStream):
	$Background.stream = stream
