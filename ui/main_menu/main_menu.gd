extends Control


export var _background_music: AudioStream


func _ready():
	_init_buttons()
	_set_background_music()


func _on_start_pressed():
	# Not via PackedScene because of cyclic dependencies.
	get_tree().change_scene("res://level/level.tscn")


func _on_exit_pressed():
	get_tree().quit()


func _init_buttons():
	yield(get_tree().create_timer(1.0), "timeout")
	$Buttons/AnimationPlayer.play("buttons_slide_in")
	yield($Buttons/AnimationPlayer, "animation_finished")
	$Buttons/Start.grab_focus()


func _set_background_music():
	AudioController.change_background_music(_background_music)
