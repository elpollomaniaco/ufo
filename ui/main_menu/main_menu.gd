extends Control


const LEVEL_PATH: String = "res://level/level.tscn"

export var _background_music: AudioStream

var _loader: ResourceInteractiveLoader
var _level_resource: Resource


func _ready():
	_set_background_music()
	# warning-ignore:return_value_discarded
	SceneController.connect("loading_progress_changed", self, "_on_loading_progress_changed")
	# warning-ignore:return_value_discarded
	SceneController.connect("scene_loaded", self, "_on_scene_loaded")
	SceneController.load_scene(LEVEL_PATH)


func _on_start_pressed():
	$Buttons/AnimationPlayer.play("buttons_slide_out")
	yield($Buttons/AnimationPlayer, "animation_finished")
	yield(get_tree(),"idle_frame") # Change starts a little bit to early.
	SceneController.change_scene(_level_resource)

func _on_exit_pressed():
	get_tree().quit()


func _set_background_music():
	AudioController.change_background_music(_background_music)


func _on_loading_progress_changed(progress: float):
	$Loading/Progress.value = progress


func _on_scene_loaded(level_resource: Resource):
	_level_resource = level_resource
	$Loading.hide()
	$Buttons/AnimationPlayer.play("buttons_slide_in")
	yield($Buttons/AnimationPlayer, "animation_finished")
	$Buttons/Start.grab_focus()
